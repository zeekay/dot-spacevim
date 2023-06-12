function! adaptor#before() abort
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
      \ 'enable_clang_complete': 0,
      \ 'enable_jedi':           0,
      \ 'enable_necoghc':        0,
      \ 'enable_tern':           0,
      \ 'enable_racer':          0,
      \ 'enable_typescript':     0,
  \ }
  let options.polyglot = {'enable_ghcmod': 0}

  let &rtp.=','.expand('~/.vim/addons/vice')

  call vice#Initialize(options)
endfunction

function! adaptor#after() abort
  " Prevent cursor from moving when leaving insert mode
  inoremap <silent> <Esc> <Esc>`^

  " Lazy :
  nnoremap ; :

  " Mappings
  nnoremap <leader>g :GitGutterToggle<cr>
  nnoremap <leader>i :IndentGuidesToggle<cr>
  nnoremap <leader>m :set mouse=a<cr>
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
  unmap  <leader>qc
  unmap  <leader>qr
  unmap  <leader>ql
  unmap  <leader>qp
  unmap  <leader>qn
  unmap  <leader>nr
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
endfunction
