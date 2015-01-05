vim-websearch
=============

trigger a web search from within vim

variables:

  variable name        | possible values      | info
  ---------------------+----------------------+-------------------------------
  g:web_search_engine  | "google", "duckduck" | choose your search engine
                       |                      | default: "duckduck"
  ---------------------+----------------------+-------------------------------
  g:web_search_query   | any string           | if set g:web_search_engine has
                       |                      | no effect.
                       |                      | your search term will be added
                       |                      | to this.
                       |                      | no default.
  ---------------------+----------------------+-------------------------------
  g:web_search_browser | "lynx", "chromium"   | choose your browser
                       |                      | default: "lynx"
  ---------------------+----------------------+-------------------------------
  g:web_search_command | any string           | if set g:web_search_browser
                       |                      | has no effect.
                       |                      | your favorite browser.
                       |                      | no default.

the default is to search in duckduckgo with lynx.
to use f.e. firefox with yahoo put this in your .vimrc:
```
  let g:web_search_command = "firefox"
  let g:web_search_query = "https://search.yahoo.com/search;?p="
```

to use f.e. chromium with google put this in your .vimrc:
```
  let g:web_search_engine = "google"
  let g:web_search_browser = "chromium"
```

here are some possible mappings:
```
  " search for word under cursor in normal mode
  nnoremap <leader>w :WebSearchCursor<CR>
  " search for selection in visual mode
  vnoremap <leader>w :WebSearchVisual<CR>
```

