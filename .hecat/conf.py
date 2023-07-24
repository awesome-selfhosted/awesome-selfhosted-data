# Configuration file for the Sphinx documentation builder.
# https://www.sphinx-doc.org/en/master/usage/configuration.html
project = 'awesome-selfhosted'
author = 'awesome-selfhosted community'
version = '1.0.0'
release = '1.0.0'
copyright = '2015-2023, the awesome-selfhosted community'
language = 'en'
html_title = 'awesome-selfhosted'
html_theme = 'furo'
html_show_sphinx = False
html_show_search_summary = True
html_copy_source = False
html_show_copyright = True
html_use_opensearch = 'https://nodiscc.github.io/awesome-selfhosted-html-preview/'
html_favicon = '../_static/favicon.ico'
html_logo = '../_static/logo.svg'
extensions = ['myst_parser', 'sphinx_design']
source_suffix = ['.md']
templates_path = ['_templates']
exclude_patterns = []
html_static_path = ['../_static']

# myst-parser configuration (https://myst-parser.readthedocs.io/en/latest/configuration.html)
myst_enable_extensions = ['fieldlist']
myst_html_meta = {
    "description lang=en": "A list of Free Software network services and web applications which can be hosted on your own servers",
    "charset": "UTF-8"
}

# theme configuration (https://pradyunsg.me/furo/customisation/)
html_theme_options = {
    "top_of_page_button": None,
    # "announcement": "Example announcement!"
    "source_repository": "https://github.com/awesome-selfhosted/awesome-selfhosted-data",
    "source_branch": "master",
    "footer_icons": [
        {
            "name": "GitHub",
            "url": "https://github.com/awesome-selfhosted/awesome-selfhosted-data",
            "html": """
                <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"></path>
                </svg>
            """,
            "class": "",
        },
    ]
}
