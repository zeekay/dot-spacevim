func! adaptor#before() abort

  "\ 'github:zeekay/vice-make',
  let options = {
      \ 'addons': [
          \ 'github:zeekay/vice-colorful',
          \ 'github:zeekay/vice-git',
          \ 'github:zeekay/vice-markdown',
          \ 'github:zeekay/vice-nerdtree',
          \ 'github:zeekay/vice-polyglot',
          \ 'github:zeekay/vice-undo',
          \ 'github:zeekay/vice-nerdtree',
          \ 'github:zeekay/vice-standard-issue',
          \ 'github:zeekay/vice-lightline',
          \ 'github:tpope/vim-vinegar',
          \ 'github:godlygeek/tabular',
      \ ],
      \ 'commands': {
          \ 'Beautify':           ['github:zeekay/vim-beautify'],
          \ 'Neoformat':          ['github:sbdchd/neoformat'],
          \ 'EasyAlign':          ['github:junegunn/vim-easy-align'],
          \ 'FlappyVird':         ['github:mattn/flappyvird-vim'],
          \ 'GitGutterToggle':    ['github:airblade/vim-gitgutter'],
          \ 'IndentGuidesToggle': ['github:nathanaelkane/vim-indent-guides'],
          \ 'Sum':                ['github:zeekay/visSum.vim'],
      \ }
  \ }

  let options.complete = {
      \ 'enable_clang_complete': 1,
      \ 'enable_jedi':           1,
      \ 'enable_necoghc':        0,
      \ 'enable_tern':           0,
      \ 'enable_racer':          0,
      \ 'enable_typescript':     1,
  \ }
  let options.polyglot = {'enable_ghcmod': 0}

  let &rtp.=','.expand('~/.vim/addons/vice')

  call vice#Initialize(options)
endf

func! adaptor#after() abort
  " Prevent cursor from moving when leaving insert mode
  inoremap <silent> <Esc> <Esc>`^

  " Lazy :
  nnoremap ; :

  " Mappings
  nnoremap <leader>g :GitGutterToggle<cr>
  nnoremap <leader>i :IndentGuidesToggle<cr>
  nnoremap <leader>n :NERDTreeToggle<cr>
  nnoremap <leader>q :call vice#standard_issue#smart_quit()<cr>
  nnoremap Q :call vice#standard_issue#smart_quit()<cr>
  nnoremap J <c-d>
  nnoremap K <c-u>
  vnoremap J <c-d>
  vnoremap K <c-u>
  inoremap <c-u> <c-o>dd

  " au filetype go nnoremap <buffer> <silent> K <c-u>

  " Remove standard spacevim mappings which conflict with \q
  silent! unmap  <leader>qc
  silent! unmap  <leader>qr
  silent! unmap  <leader>ql
  silent! unmap  <leader>qp
  silent! unmap  <leader>qn
  silent! unmap  <leader>nr
  " Remove mappings that begin with <esc> which slow leaving insert mode
  " iunmap  <Esc><
  " iunmap  <Esc>>
  " iunmap  <Esc>-
  " iunmap  <Esc>=
  " iunmap  <Esc>L
  " iunmap  <Esc>K
  " iunmap  <Esc>J
  " iunmap  <Esc>H
  " iunmap  <Esc>l
  " iunmap  <Esc>k
  " iunmap  <Esc>j
  " iunmap  <Esc>h
  " iunmap  <Esc>OD
  " iunmap  <Esc>OC
  " iunmap  <Esc>OB
  " iunmap  <Esc>OA

  noremap <C-n> <Plug>(neural_prompt)

  let g:neomake_python_enabled_makers = ['flake8']
  let g:neomake_python_flake8_maker = {
      \ 'args': ['--max-line-length=120', '--ignore=E501,E302'],
      \ 'errorformat':
          \ '%E%f:%l:%c: %t%n %m,' .
          \ '%E%f:%l: %t%n %m,' .
          \ '%W%f:%l:%c: %t%n %m,' .
          \ '%W%f:%l: %t%n %m,' .
          \ '%E%f:%l:%c: %m,' .
          \ '%E%f:%l: %m,' .
          \ '%-G%.%#',
  \ }

  set showtabline=1
endf

nnoremap ZZ :wqa<cr>
set mouse=

let g:neural = {
\   'source': {
\       'openai': {
\           'api_key': $OPENAI_API_KEY,
\       },
\   },
\}

