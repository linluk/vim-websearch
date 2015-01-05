" Description {{{1
" Author: linluk  'lukas42singer (at) gmail (dot) com'
" Created: 2014/01/05
" Filename: websearch.vim
"
" opens a browser and searches the web.
"
" variables:
"
"  variable name        | possible values      | info
"  ---------------------+----------------------+-------------------------------
"  g:web_search_engine  | "google", "duckduck" | choose your search engine
"                       |                      | default: "duckduck"
"  ---------------------+----------------------+-------------------------------
"  g:web_search_query   | any string           | if set g:web_search_engine has
"                       |                      | no effect.
"                       |                      | your search term will be added
"                       |                      | to this.
"                       |                      | no default.
"  ---------------------+----------------------+-------------------------------
"  g:web_search_browser | "lynx", "chromium"   | choose your browser
"                       |                      | default: "lynx"
"  ---------------------+----------------------+-------------------------------
"  g:web_search_command | any string           | if set g:web_search_browser
"                       |                      | has no effect.
"                       |                      | your favorite browser.
"                       |                      | no default.
"
" the default is to search in duckduckgo with lynx.
" to use f.e. firefox with yahoo put this in your .vimrc:
"   let g:web_search_command = "firefox"
"   let g:web_search_query = "https://search.yahoo.com/search;?p="
"
" to use f.e. chromium with google put this in your .vimrc:
"   let g:web_search_engine = "google"
"   let g:web_search_browser = "chromium"
"
" here are some possible mappings:
"   " search for word under cursor in normal mode
"   nnoremap <leader>w :WebSearchCursor<CR>
"   " search for selection in visual mode
"   vnoremap <leader>w :WebSearchVisual<CR>
"
" TODOs:
"   use a dictionary for g:web_search_engine and g:web_search_command
"   mapping. (i have to learn it first)
"
"   add more search engines.
"
"   add support for mac (how do i test this?).
"
"   add support for windows.
"
"   test!
"

" Loaded? {{{1
if has("g:web_search_loaded")
  finish
endif
let g:web_search_loaded = 1

" Commands {{{1
command! -nargs=+ WebSearch call DoWebSearch(join([<f-args>]))
command! WebSearchCursor call DoWebSearch('<cword>')
command! -range WebSearchVisual call DoWebSearch(GetVisualSelection())

" Functions {{{1
function! GetVisualSelection() "{{{2
  " save content of register "
  let l:tmp = @"
  " yank selection in register "
  execute "normal! vgvy"
  " save content of register " to result
  let l:result = @"
  " restore register "
  let @" = l:tmp
  " return the visual selected text
  return l:result
endfunction

function! DoWebSearch(string) "{{{2
  let l:duckduck = "https://duckduckgo.com/?q="
  let l:google = "https://www.google.com/search?q="
  let l:lynx = "lynx"
  let l:chromium = "chromium-browser"
  " 1. split the search string in seperate words
  " 2. join the words seperated by +
  " 3. replace all " with an empty string
  let l:term = substitute(join(split(a:string),"+"),'"',"","g")
  if exists("g:web_search_engine")
    if g:web_search_engine == "google"
      let l:query = l:google . l:term
    endif
    if g:web_search_engine == "duckduck"
      let l:query = l:duckduck . l:term
    endif
  endif
  if exists("g:web_search_query")
    let l:query = g:web_search_query . l:term
  endif
  if !exists("l:query")
    " default search engine is duckduckgo
    let l:query = l:duckduck . l:term
  endif
  if exists("g:web_search_browser")
    if g:web_search_browser == "lynx"
      let l:browser_cmd = l:lynx
    endif
    if g:web_search_browser == "chromium"
      let l:browser_cmd = l:chromium
    endif
  endif
  if exists("g:web_search_command")
    let l:browser_cmd = g:web_search_command
  endif
  if !exists("l:browser_cmd")
    " default browser is lynx
    let l:browser_cmd = l:lynx
  endif
  execute "!" l:browser_cmd . " \"" . l:query . "\" "
endfunction

