source ../init.vim

let g:wiki_link_toggles = {
      \ 'wiki': 'WikiToggler',
      \ 'md': 'MdToggler',
      \}

function WikiToggler(url, text) abort dict
  return wiki#link#md#template(a:url . '.wiki', empty(a:text) ? a:url : a:text)
endfunction

function MdToggler(url, text) abort dict
  let l:url = substitute(a:url, '\.wiki$', '', '')
  return wiki#link#wiki#template(l:url, a:text)
endfunction

runtime plugin/wiki.vim

" Test toggle normal on regular markdown links using wiki style links
silent edit ex1-basic/index.wiki
execute "normal \<plug>(wiki-link-next)"
silent execute "normal \<Plug>(wiki-link-toggle)"
call wiki#test#assert_equal('[NewPage](NewPage.wiki)', getline('.'))
silent execute "normal \<Plug>(wiki-link-toggle)"
call wiki#test#assert_equal('[[NewPage]]', getline('.'))


if $QUIT | quitall! | endif
