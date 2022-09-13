""""""""""""""""""""""""""""""""""""""""""""""""
" Cheat sheet
""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins (specific to vim-plug):
"     Install: ':PlugInstall'
"     Remove unused: 'PlugClean'
"
" Language Server
"     Information on currently running server: ':LspStatus'
"
" General
"   Insert Mode:
"   jk <Esc> (to leave insert mode)
"
"   Normal Mode:
"   <space>bp Show previous buffer
"   <space>bn Show next buffer
"   <space>bq Quit buffer
"   <space>sv Show in vertical split
"   <space>sh Show in horizontal split
"   <space>sq Quit split
"   <space>lc Toggle cursor line
"   <space>ln Toggle line numbers
"   <space>ls Toggle spelling
"          [s and ]s to find spell check errors
"          zg to add a word to spell file
"          z= for suggestions
"   <space>w Remove all trailing whitespace
"
" Git fugitive:
"   <space>gb Show git blame window
"
" File explorer
"   <space>t Toggle file explorer
"   <space>o Open file explorer at current file
"          ? Toggle help for file explorer
"
" Fuzzy finder (Fzf)
"   <space>f Open file search
"          Crtl-h Open file in horizontal split
"          Crtl-v Open file in vertical split
"          Crtl-/ Toggle preview
"
" Code commenting
"   <space>c<space> Toggle comment
"
" Vim-Lsp
"   <space>i  Show doxygen information
"   <space>p  Peek definition/declaration
"   <space>d  Goto definition/declaration
"   <space>r  Show all references
"   <space>ac Show possible code actions
"   <space>cf Format file (in case of visual mode: Format selected range)
"   <F2>      Rename


""""""""""""""""""""""""""""""""""""""""""""""""
" TODO
""""""""""""""""""""""""""""""""""""""""""""""""
" [ ] Test smooth scrolling
" [ ] Look deeper into auto pairs plugin
" [ ] Look deeper into vim-surround plugin
" [ ] Document about git plugins
" [ ] Find out about terminal mode (see Michaels nvimrc)
" [ ] Configure airlines
" [ ] Check if other comment plugin is easier modifiable

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin manager
""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'lifepillar/vim-solarized8'              " Solarized scheme
Plug 'vim-airline/vim-airline'                " Vimscript powerline plugin
Plug 'vim-airline/vim-airline-themes'         " Themes for above plugin

Plug 'tpope/vim-sensible'                     " Sane defaults/minor optimizations
Plug 'thekelvinliu/kwbd'                     " Keep window on buffer delete
Plug 'christoomey/vim-tmux-navigator'         " Navigation between tmux/vim (additional settings in .tmux.conf needed!)

Plug 'jiangmiao/auto-pairs'                   " Automatic pairs of parenthesis, brackets etc.
Plug 'machakann/vim-highlightedyank'          " Hightlight yanked text
Plug 'ntpeters/vim-better-whitespace'         " Mark trailing whitespace and functionality to remove it
Plug 'tpope/vim-surround'                     " Add shortcut for changing surrounding of expression

Plug 'airblade/vim-gitgutter'                 " Show git status of lines in sidebar
Plug 'tpope/vim-fugitive'                     " Add direct git control into vim

Plug 'scrooloose/nerdtree'                    " File tree explorer
Plug 'scrooloose/nerdcommenter'               " Code commenting

Plug 'junegunn/fzf'                           " Fuzzy find (e.g. for file search)
Plug 'junegunn/fzf.vim'                       " Needs both following https://github.com/junegunn/fzf.vim#installation

Plug 'prabirshrestha/vim-lsp'                 " Language server protocol for various languages
"Plug 'mattn/vim-lsp-settings'                " Prevents semantic highlighting

Plug 'prabirshrestha/asyncomplete.vim'        " Autocompletion framework
Plug 'prabirshrestha/asyncomplete-buffer.vim' " Completion for the buffer
Plug 'prabirshrestha/asyncomplete-file.vim'   " Completion for filesystem
Plug 'prabirshrestha/asyncomplete-lsp.vim'    " Completion for language server

call plug#end()

" Load plugins not overwriting own settings
runtime! plugin/sensible.vim

""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""

" Update every 100ms (e.g. swap files are written to disk and gitgutter
" plugins updates)
set updatetime=100

" Don't close current buffer if opening new one
set hidden

" Show line numbers
set number

" Set cursor line on by default
set cursorline

" Highlight search results
set hlsearch

" Ignore case for searching
set ignorecase

" Override 'ignorecase' if upper case characters are used
set smartcase

" Show incremental results while typing during search
set incsearch

" Enable mouse
set mouse=a

" Open vertical splits to the right
set splitright

" Smooth scolling
noremap <ScrollWheelUp> <C-Y><C-Y><C-Y>
noremap <ScrollWheelDown> <C-E><C-E><C-E>

"Try to recognize file type and set appropriate options
filetype on

" Load plugin settings for file type
filetype plugin on

" Load indent file for file type
filetype indent on

" Use true color support in terminal
set termguicolors " Needs to be set before color scheme

" Use syntax highlighting
syntax on " Needs to be set before color scheme

" Highlight doxygen by default
let g:load_doxygen_syntax = 1

" Color scheme
set background=light
colorscheme solarized8

" Highlight triangle brackets
set matchpairs+=<:>

" Shell used inside vim
set shell=/bin/zsh

" Set file encoding
set fenc=utf-8

" Use clipboard with Crtl+C and Ctrl+V (not to middle click buffer)
set clipboard=unnamedplus

" Offset to screen border while scrolling
set scrolloff=3

" Show status line always
set laststatus=2

" Set some triggers for checking if the open file has changed from version
" control, etc. source: http://stackoverflow.com/a/927634
autocmd CursorHold * if getcmdwintype() == '' | checktime | endif
autocmd WinEnter * if getcmdwintype() == '' | checktime | endif
autocmd BufWinEnter * if getcmdwintype() == '' | checktime | endif

" Jump to last position when reopening file (see
" https://askubuntu.com/a/202077)
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Tabs (sw = Shift width, ts = tab stop)
autocmd FileType * setlocal sw=4 ts=4 expandtab
autocmd FileType python setlocal sw=4 ts=4 expandtab
autocmd FileType cpp setlocal sw=2 ts=2 expandtab
set list listchars=tab:>- " Print into tabs to make them visible

""""""""""""""""""""""""""""""""""""""""""""""""
" General keybindings
""""""""""""""""""""""""""""""""""""""""""""""""

" Use <space> instead of \ for commands
let mapleader = " "

" Escape without moving hand
inoremap jk <ESC>

" Show previous buffer
nnoremap <silent> <Leader>bp :bp<CR>

" Show next buffer
nnoremap <silent> <Leader>bn :bn<CR>

" Quit buffer
nnoremap <silent> <Leader>bq :KWBD<CR>

" Vertical split
nnoremap <silent> <Leader>sv :vsplit<CR>

" Horizontal split
nnoremap <silent> <Leader>sh :vsplit<CR>

" Quit split
nnoremap <silent> <Leader>sq :hide<CR>

" Toggle line numbers
nnoremap <silent> <Leader>ln :set number!<CR>

" Toggle cursor line
nnoremap <silent> <Leader>lc :set cursorline!<CR>

" Toggle spelling
nnoremap <silent> <Leader>ls :set spell!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" Spell check (no plugin required)
""""""""""""""""""""""""""""""""""""""""""""""""

" Reference:
" http://thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
" Keybindings are documented in "Cheat sheet" section
set spelllang=en
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add

""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""

" Populate g:airline_symbols with powerline symbols
let g:airline_powerline_fonts = 1
" Use solarized scheme
let g:airline_theme = "solarized"
" Enable tabline
let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""
" Better whitespace
""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace in file
nnoremap <silent> <Leader>w :StripWhitespace!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighted yank
""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight until new text is yanked or insertion starts
let g:highlightedyank_highlight_duration = -1

""""""""""""""""""""""""""""""""""""""""""""""""
" Auto pairs
""""""""""""""""""""""""""""""""""""""""""""""""

" Do not set any shortcuts
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''

""""""""""""""""""""""""""""""""""""""""""""""""
" Vim fugitive
""""""""""""""""""""""""""""""""""""""""""""""""

" Show git blame bar
nnoremap <Leader>gb :G blame<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Tree
""""""""""""""""""""""""""""""""""""""""""""""""

" Open in file explorer
nnoremap <Leader>t :NERDTreeToggle<CR>

" Open current file in file explorer
nnoremap <Leader>o :NERDTreeFind<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif


""""""""""""""""""""""""""""""""""""""""""""""""
" NERD commenter
""""""""""""""""""""""""""""""""""""""""""""""""
" default binds: https://github.com/preservim/nerdcommenter#default-mappings

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""

" Set prefix for all fzf commands
let g:fzf_command_prefix = 'Fzf'

" Use 'h' for opening file in horizontal split (see https://github.com/junegunn/fzf/blob/master/README-VIM.md)
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-h': 'split',
            \ 'ctrl-v': 'vsplit' }

" Use larger hight than default (again see https://github.com/junegunn/fzf/blob/master/README-VIM.md)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" Preview window on by default and on right of fzf window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Open file search
nnoremap <Leader>f :FzfFiles<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp
""""""""""""""""""""""""""""""""""""""""""""""""

let g:lsp_diagnostics_echo_cursor=1
let g:lsp_semantic_enabled=1
let g:lsp_highlight_references_enabled=1

nnoremap <silent> <Leader>i :LspHover<CR>
nnoremap <silent> <Leader>p :LspPeekDefinition<CR>
nnoremap <silent> <Leader>d :LspDefinition<CR>
nnoremap <silent> <Leader>r :LspReferences<CR>
nnoremap <silent> <Leader>a :LspCodeAction<CR>
nnoremap <silent> <Leader>cf :LspDocumentFormat<CR>
vnoremap <silent> <Leader>cf :LspDocumentRangeFormat<CR>
nnoremap <silent> <F2> :LspRename<CR>

if executable('clangd')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': ['clangd', "--header-insertion=never",
                \                   "--suggest-missing-includes",
                \                   "--cross-file-rename",
                \                   "--clang-tidy"],
                \ 'whitelist': ['cpp'],
                \ 'semantic_highlight': {
                \     'entity.name.function.cpp': 'CppFunction',
                \     'entity.name.function.method.cpp': 'CppMethod',
                \     'entity.name.function.method.static.cpp': 'CppStaticMethod',
                \     'entity.name.function.preprocessor.cpp': 'CppPreprocessor',
                \     'entity.name.namespace.cpp': 'CppNamespace',
                \     'entity.name.other.dependent.cpp': 'CppOtherDependent',
                \     'entity.name.type.class.cpp': 'CppClass',
                \     'entity.name.type.dependent.cpp': 'CppTypeDependent',
                \     'entity.name.type.enum.cpp': 'CppEnum',
                \     'entity.name.type.template.cpp': 'CppTemplate',
                \     'entity.name.type.typedef.cpp': 'CppTypedef',
                \     'meta.disabled': 'CppDisabled',
                \     'storage.type.primitive.cpp': 'CppPrimitiveType',
                \     'variable.other.cpp': 'CppOtherVariable',
                \     'variable.other.enummember.cpp': 'CppEnumMember',
                \     'variable.other.field.cpp': 'CppFieldVariable',
                \     'variable.other.field.static.cpp': 'CppFieldStaticVariable',
                \     'variable.other.local.cpp': 'CppLocalVariable',
                \     'variable.parameter.cpp': 'CppParameter'
                \ }
                \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'whitelist': ['python'],
                \ 'workspace_config': {'pyls': {
                \     'configurationSources': ['flake8'],
                \     'plugins': {'pylint': {'enabled': v:true}}
                \ }}})
endif

" Make it easier to set groups by color. Specific for the solarized color scheme.
hi! link Black Normal
hi! link Gray Comment
hi! link Cyan Constant
hi! link Blue Identifier
hi! link Green Statement
hi! link Orange PreProc
hi! link Yellow Type
hi! link Violet Underlined
hi! link Magenta Todo

" Commented out is black without settings a background, which conflicts with
" highlighted line
"hi! link CppFunction           Black
"hi! link CppMethod             Black
"hi! link CppStaticMethod       Black
hi! link CppPreprocessor       Orange
"hi! link CppNamespace          Black
"hi! link CppOtherDependent     Black
"hi! link CppClass              Black
"hi! link CppTypeDependent      Black
"hi! link CppEnum               Black
"hi! link CppTemplate           Black
"hi! link CppTypedef            Black
"hi! link CppDisabled           Black
"hi! link CppPrimitiveType      Black
"hi! link CppOtherVariable      Black
hi! link CppEnumMember         Blue
hi! link CppFieldVariable      Blue
hi! link CppFieldStaticVariable Blue
"hi! link CppLocalVariable      Black
"hi! link CppParameter          Black

"hi! link cStorageClass         Black
"hi! link cType                 Black
"hi! link cppStructure          Black

""""""""""""""""""""""""""""""""""""""""""""""""
" asyncomplete
""""""""""""""""""""""""""""""""""""""""""""""""

" Bindings to trigger completion with Tab (see
" https://github.com/prabirshrestha/asyncomplete.vim)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Retrigger completion with Ctrl-Space
imap <c-space> <Plug>(asyncomplete_force_refresh)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" asyncomplete-file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" see https://github.com/prabirshrestha/asyncomplete-file.vim
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'whitelist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" asyncomplete-buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" see https://github.com/prabirshrestha/asyncomplete-buffer.vim
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'allowlist': ['*'],
            \ 'blocklist': [],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ 'config': {
            \    'max_buffer_size': 5000000,
            \  },
            \ }))


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal colorcolumn=73
