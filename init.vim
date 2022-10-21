syntax on
syntax sync minlines=50
syntax sync maxlines=100
scriptencoding utf-8
filetype on
filetype indent on
filetype plugin on

" Remove existing autocommands, in case this file is sourced more than once.
:autocmd!

autocmd FileType php setlocal smartindent
autocmd BufRead,BufNewFile *.mako setlocal syntax=mako
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown linebreak textwidth=100 colorcolumn=0 foldcolumn=4 numberwidth=5
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.html.hbs set filetype=html
autocmd BufNewFile,BufRead *.hbs.html set filetype=html
autocmd BufNewFile,BufRead *.pug set filetype=jade
autocmd BufNewFile,BufRead .PHSEARCH_SETTINGS set filetype=yaml
autocmd BufNewFile,BufRead *phgroup.com*.conf,generic.conf,httpd.conf,server.conf set filetype=apache
autocmd FileType gitcommit setlocal colorcolumn=51
autocmd FileType text|markdown setlocal fo+=al " 'a' is automatic paragraph formatting
autocmd FileType html setlocal colorcolumn=0 textwidth=0 " Allow HTML lines to be much longer than other code.
autocmd FileType sh setlocal textwidth=0
autocmd BufRead * match ExtraWhitespace /\s\+$/  
autocmd BufRead * highlight ExtraWhitespace ctermbg=white guifg=#FF0000

" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

set nocompatible
set backup
set updatetime=2000 " milliseconds to wait before writing backup file
set hidden " Allow editing of different files without saving current buffer first.
" set runtimepath^=~/.vim,~/.vim/after
" set packpath^=~/.vim
" set backupdir=~/.vim/backup
" set directory=~/.vim/tmp
set path+=** " Allow recursive searching in current directory
set mouse=a

set relativenumber
set number
set cursorline
set listchars=trail:•,tab:→\ ,nbsp:░
set showmatch
set showmode
set fillchars=vert:▍,fold:╌,foldopen:▾,foldsep:│,foldclose:▸
set laststatus=2 " 2 means always
set statusline=%#TabLineSel#[%02n]%0*\ %{expand('%:.')}\ %([%3*%m%*%r%h]%)%=%4l,%c\ ·\ %3P\ of\ %L
set diffopt=vertical
set signcolumn=yes

set foldlevel=99
set foldnestmax=5
set foldcolumn=1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set textwidth=100
set colorcolumn=100
set synmaxcol=200
set breakindent

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set autoindent
set backspace=indent,eol,start

set formatoptions=tcrqnljv1 " see fo-table help for details

set lazyredraw " Don't update screen while executing macros.
set visualbell
set scrolloff=4
set list
set wildmode=longest,list " Show all matches when using tab completion of filenames
set completeopt=menu,longest,preview " More sensible completion options.
set noea " keep existing window sizes when splitting or closing a window

set gdefault " Automatically assume the :s /g flag (replace every match on a ling).
set ignorecase
set smartcase
set hlsearch
set incsearch

set guifont=JetBrainsMono_Nerd_Font_Mono:h12
set background=dark

" \ is a bit awkward to reach
let mapleader = ","

" Bubble single lines
nnoremap <D-k> ddkP
nnoremap <D-j> ddp

" Bubble paragraph
nnoremap <D-K> dap{{p
nnoremap <D-J> dap}p

nmap <D-[> :bp<CR>
nmap <D-]> :bn<CR>
noremap <tab> %
nnoremap <leader>l gqq
nnoremap <silent> <leader>h :nohl<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Expand %% into the current file's path.
cnoremap %% <C-R>=expand('%:.:h').'/'<cr>

inoremap kj <esc>
inoremap <C-l> <Del>

vnoremap <silent> K :m'>-2<CR>gv=gv
vnoremap <silent> J :m'>+1<CR>gv=gv

if exists("g:neovide")
    " Make stuff feel more macOS-native
    let g:neovide_input_use_logo = v:true
    nnoremap <silent> <D-v> "+p
    inoremap <silent> <D-v> <Esc>"+pa
    vnoremap <silent> <D-c> "+y

    let g:neovide_cursor_vfx_mode = ""
    let g:neovide_cursor_animation_length = 0
    cd ~
endif

" runtime macros/matchit.vim

let g:go_bin_path = '~/Applications/homebrew/opt/go/bin'
let g:matchparen_insert_timeout=5
let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
let g:indent_blankline_use_treesitter = v:true
" I use C-hjkl for window navigation, so need to prevent COQ from overriding those
let g:coq_settings = { "auto_start": "shut-up", "keymap.recommended": v:false, "keymap.bigger_preview": v:null, "keymap.jump_to_mark": v:null }

call plug#begin()
Plug 'williamboman/mason.nvim' " for easy treesitter language installs
Plug 'nvim-lua/plenary.nvim' " misc handy Lua functions
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'tpope/vim-commentary', { 'branch': 'master' }
Plug 'tpope/vim-sleuth', { 'branch': 'master' }
Plug 'windwp/nvim-autopairs'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'rodjek/vim-puppet'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

highlight link ScrollView PmenuSbar
hi StatusLine guibg=#343952 guifg=#e8ebfc
hi StatusLineNC guibg=#343952 guifg=#929be5
hi VertSplit guifg=#464f7f
hi TabLine guibg=#1e2030 guifg=#929be5

lua << EOL

require("mason").setup()

-- Global LSP floating border override
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local v_minor = vim.version().minor
local v_major = vim.version().major
local use_ts_integrations = v_major >= 1 or v_minor >= 8

require('catppuccin').setup({
    term_colors = false,
    integrations = {
        telescope = true,
        treesitter = use_ts_integrations,
    },
})

local telescope = require('telescope')
local tsc_builtin = require('telescope.builtin')
local lsp = require "lspconfig"
local coq = require "coq"

telescope.setup()
telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>f', tsc_builtin.find_files, {})
vim.keymap.set('n', '<leader>g', tsc_builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', tsc_builtin.buffers, {})
vim.keymap.set('n', '<D-i>', vim.diagnostic.open_float, { noremap=true, silent=true })

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, bufopts)
end

lsp.rust_analyzer.setup(
    coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        settings = {
            ["rust_analyzer"] = {
                checkOnSave = { command = "cargo clippy" }
            },
        },
    })
)
lsp.gopls.setup( coq.lsp_ensure_capabilities({ on_attach = on_attach, }))
lsp.denols.setup( coq.lsp_ensure_capabilities({ on_attach = on_attach, }))
lsp.solargraph.setup( coq.lsp_ensure_capabilities({ on_attach = on_attach, }))


require("indent_blankline").setup {
    use_treesitter = true,
    show_current_context = false,
    show_current_context_start = false,
}

local vlines = require("lsp_lines")
vlines.setup()
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set(
    "",
    "<Leader>v",
    vlines.toggle,
    { desc = "Toggle lsp_lines" }
)

require'nvim-treesitter.configs'.setup {
    -- ensure_installed = { "javascript", "rust", "ruby", "go", "markdown", "html" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"apache"},
    },
}


local nap = require("nvim-autopairs")
local remap = vim.api.nvim_set_keymap
nap.setup {
    check_ts = true,
    map_bs = false,
    map_cr = false,
}
_G.MUtils= {}
MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return nap.esc('<c-y>')
    else
      return nap.esc('<c-e>') .. nap.autopairs_cr()
    end
  else
    return nap.autopairs_cr()
  end
end

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return nap.esc('<c-e>') .. nap.autopairs_bs()
  else
    return nap.autopairs_bs()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

EOL

colo catppuccin
Catppuccin macchiato
