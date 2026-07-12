#!/usr/bin/env bash
# OpenSSF Scorecard gate for awesome-selfhosted-data submissions.
#
# Runs OpenSSF Scorecard (https://github.com/ossf/scorecard) against the
# source_code_url of software entries and fails when the aggregate score is below
# SCORECARD_THRESHOLD. Invoked by `make scorecard` - see the Makefile for the
# configurable variables.
#
# By default it checks the software/*.yml files added/modified between
# SCORECARD_BASE and HEAD (i.e. the current pull request). Set SCORECARD_REPO to
# check a single repository instead (handy for reviewing one submission locally).
#
# Only GitHub and GitLab are supported by Scorecard; entries on other forges are
# skipped (not failed). Tooling/evaluation errors (network, auth, 404, rate limit)
# are also skipped unless SCORECARD_STRICT is set to a non-empty value.
#
# Authentication is read from the environment by the scorecard binary itself:
#   - GitHub App:  GITHUB_APP_ID, GITHUB_APP_INSTALLATION_ID, GITHUB_APP_KEY_PATH
#   - or PAT:      GITHUB_TOKEN / GITHUB_AUTH_TOKEN
#   - GitLab:      GITLAB_AUTH_TOKEN
set -euo pipefail

SCORECARD_BIN="${SCORECARD_BIN:-./bin/scorecard}"
SCORECARD_THRESHOLD="${SCORECARD_THRESHOLD:-5.0}"
SCORECARD_BASE="${SCORECARD_BASE:-origin/master}"
SCORECARD_REPO="${SCORECARD_REPO:-}"
SCORECARD_STRICT="${SCORECARD_STRICT:-}"

# Collect the "<label> <url>" targets to evaluate.
targets=()
if [ -n "$SCORECARD_REPO" ]; then
  targets+=("(manual) $SCORECARD_REPO")
else
  files=()
  while IFS= read -r line; do
    [ -n "$line" ] && files+=("$line")
  done < <(git diff --name-only --diff-filter=AM "$SCORECARD_BASE"...HEAD -- software/ 2>/dev/null || true)
  for f in "${files[@]:-}"; do
    [ -n "$f" ] || continue
    url=$(sed -n 's/^source_code_url:[[:space:]]*//p' "$f" | head -n1 | tr -d '\r"' )
    [ -n "$url" ] && targets+=("$f $url")
  done
fi

if [ "${#targets[@]}" -eq 0 ]; then
  echo "OpenSSF Scorecard: no added/modified software entries to check."
  exit 0
fi

echo "OpenSSF Scorecard: threshold >= $SCORECARD_THRESHOLD (strict=${SCORECARD_STRICT:-off})"

fail=0
for t in "${targets[@]}"; do
  file="${t%% *}"
  url="${t#* }"
  # normalize https://host/owner/repo/ -> host/owner/repo
  repo=$(echo "$url" | sed -E 's#^https?://##; s#/+$##')

  case "$repo" in
    github.com/*|gitlab.com/*) ;;
    *)
      echo "SKIP  $file -> $url (unsupported forge; Scorecard supports GitHub/GitLab only)"
      continue
      ;;
  esac

  echo "----------------------------------------------------------------------"
  echo "CHECK $file -> $repo"

  if ! json=$("$SCORECARD_BIN" --repo="$repo" --format=json 2>/dev/null); then
    echo "WARN  could not run Scorecard on $repo (network/auth/404/rate-limit?)"
    [ -n "$SCORECARD_STRICT" ] && { echo "STRICT: treating as failure."; fail=1; }
    continue
  fi

  score=$(printf '%s' "$json" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("score", -1))' 2>/dev/null || echo "-1")

  # per-check breakdown, lowest scores first
  printf '%s' "$json" | python3 -c '
import sys, json
data = json.load(sys.stdin)
for c in sorted(data.get("checks", []), key=lambda x: (x.get("score") is not None, x.get("score") or 0)):
    s = c.get("score")
    s = "?" if s is None or s < 0 else str(s)
    print("        %-22s %3s  %s" % (c.get("name", "?"), s, (c.get("reason") or "")))
' 2>/dev/null || true

  if awk "BEGIN{exit !($score < 0)}"; then
    echo "WARN  $repo: aggregate score unavailable (score=$score)"
    [ -n "$SCORECARD_STRICT" ] && { echo "STRICT: treating as failure."; fail=1; }
    continue
  fi

  if awk "BEGIN{exit !($score < $SCORECARD_THRESHOLD)}"; then
    echo "FAIL  $repo: score $score < threshold $SCORECARD_THRESHOLD"
    fail=1
  else
    echo "PASS  $repo: score $score >= threshold $SCORECARD_THRESHOLD"
  fi
done

echo "----------------------------------------------------------------------"
if [ "$fail" -ne 0 ]; then
  echo "OpenSSF Scorecard gate: FAILED"
  echo "See https://github.com/ossf/scorecard/blob/main/docs/checks.md for remediation."
  exit 1
fi
echo "OpenSSF Scorecard gate: PASSED"
exit 0
