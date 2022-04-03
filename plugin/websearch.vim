" Comment {{{1
" Author: linluk  'lukas42singer (at) gmail (dot) com'
" Created: 2015/01/05
" Filename: websearch.vim
" License: Copyright (C) 2015 Lukas Singer
"          GNU GPL v3 see <LICENSE> for more info.
" TODOs:
"   use a dictionary (or similar)for g:web_search_engine and
"   g:web_search_command mapping. (i have to learn about it first)
"
"   add more search engines.
"
"   add support for mac (how do i test this?).
"
"   add support for windows.
"
"   test!
"
" Changes:
"   2015/01/06, linluk:
"     added a default mapping. turned on by:
"       let g:web_search_use_default_mapping = "yes"
"     in your vimrc file.
"     deleted most of the header-comment
"     (this stuff can be found in README.md).
"

" Loaded? {{{1
if exists("g:web_search_loaded")
  finish
endif
let g:web_search_loaded = 1

" Commands {{{1
" :WebSearch needs one or more arguments
command! -nargs=+ WebSearch call DoWebSearch(join([<f-args>]))
" :WebSearchCursor didn't take any arguments
command! WebSearchCursor call DoWebSearch('<cword>')
" :WebSearchVisual has -range because it can be called from visual mode, range
" is not used, i have my own function.
command! -range WebSearchVisual call DoWebSearch(GetVisualSelection())
" :WebSearchAbout
command! WebSearchAbout call WebSearchAbout()

" Mappings {{{1
if exists("g:web_search_use_default_mapping")
  if g:web_search_use_default_mapping == "yes"
    " search for word under cursor in normal mode
    nnoremap <leader>ws :WebSearchCursor<CR>
    " search for selection in visual mode
    vnoremap <leader>ws :WebSearchVisual<CR>
  endif
endif

" Functions {{{1
function! WebSearchAbout() "{{{2
  echom "<vim-websearch> Copyright (C) 2015 Lukas Singer"
  echom "This program comes with ABSOLUTELY NO WARRANTY;"
  echom "This is free software, and you are welcome to redistribute it;"
  echom " "
  echom "usage:"
  echom "  :WebSearch <search-term>        search for <search-term>"
  echom "  :WebSearchAbout                 prints this help text"
  echom "  :WebSearchCursor (or mapping)   search the word under cursor"
  echom "  :WebSearchVisual (or mapping)   search for visual selection"
  echom " "
  echom "thanks for using vim-websearch"
  echom "visit: <https://github.com/linluk/vim-websearch>"
  echom " "
  echom "your settings:"
  if exists("g:web_search_query")
    echom "  your search query is: " . g:web_search_query . "."
  elseif exists("g:web_search_engine")
    echom "  your search engine is: " . g:web_search_engine . "."
  else
    echom "  you use the default search engine."
  endif
  if exists("g:web_search_command")
    echom "  your search command is: " . g:web_search_command . "."
  elseif exists("g:web_search_browser")
    echom "  your browser is: " . g:web_search_browser . "."
  else
    echom "  you use the default browser."
  endif
  if exists("g:web_search_use_default_mapping")
    if g:web_search_use_default_mapping == "yes"
      echom "  you use the default mapping, try <leader>ws in normal or visual mode."
    else
      echom "  default mappings are explicitly turned of."
    endif
  else
    echom "  you don't use the default mapping."
  end
endfunction

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
  if exists("g:web_search_query_suffix")
    let l:query = l:query . g:web_search_query_suffix
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

