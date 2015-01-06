vim-websearch
=============

vim-websearch allows you to trigger a web search from within vim.
you can search for the word under the cursor, for a visual selection or for something you type.

Configuration
=============

variables:

  variable name        | possible values      | info
  ---------------------|----------------------|-------------------------------
  g:web_search_engine  | "google", "duckduck" | choose your search engine. default: "duckduck"
  g:web_search_query   | any string           | if set g:web_search_engine has no effect. your search term will be added to this. no default.
  g:web_search_browser | "lynx", "chromium"   | choose your browser. default: "lynx"
  g:web_search_command | any string           | if set g:web_search_browser has no effect. your favorite browser. no default.
  g:web_search_use_default_mapping | "yes", any | if set to "yes" the default mappings get set. default: unset

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

you can also combine you favorite browser with a known search engine and viceversa:
```
  let g:web_search_command = "w3m"
  let g:web_search_engine = "duckduck"
```

if you want to use the default mapping (which is `<leader>ws` to search for the word under the cursor in normal mode or to search for the selection in visual mode) add this to your .vimrc:
```
  let g:web_search_use_default_mapping = "yes"
```

otherwise you can create your own mappings like this:
```
  " search for word under cursor in normal mode
  nnoremap <leader>w :WebSearchCursor<CR>
  " search for selection in visual mode
  vnoremap <leader>w :WebSearchVisual<CR>
```

Usage
=====
type `:WebSearchAbout` in normal mode to see the about dialog.

type `:WebSearch hello world` in normal mode to search for `hello world`.

type `:WebSearchCursor` in normal mode to search for the word under the cursor.

type `:WebSearchVisual` in visual mode to search for the selected text.

instead of typing `:WebSearchCursor` and `:WebSearchVisual` i would recommend to use the default or any other mapping.

Bugs? Features?
===============
feel free to open an issue or send a pull request.

License
=======
Copyright (C) 2015 Lukas Singer.
I use the GNU GPL v3.
See `LICENSE` for more info.

