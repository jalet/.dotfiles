local set = vim.opt

set.backup         = false
set.ch             = 0
set.clipboard      = "unnamedplus"
set.cmdheight      = 2
set.colorcolumn    = "+1"
set.completeopt    = { "menuone", "noselect" }
set.conceallevel   = 0
set.cursorline     = true
set.expandtab      = true
set.fileencoding   = "utf-8"
set.guifont        = "monospace"
set.hlsearch       = false
set.ignorecase     = true
set.incsearch      = true
set.list           = false
set.ls             = 0
set.mouse          = "a"
set.number         = true
set.numberwidth    = 4
set.pumheight      = 15
set.relativenumber = true
set.scrolloff      = 16
set.shiftwidth     = 4
set.showmode       = false
set.showtabline    = 0
set.sidescrolloff  = 8
set.signcolumn     = "yes"
set.smartcase      = true
set.smartindent    = true
set.spell          = true
set.spelllang      = { "en_gb", "en_us" }
set.splitbelow     = true
set.splitright     = true
set.undodir        = os.getenv("HOME") .. "/.vim/undo"
set.swapfile       = false
set.tabstop        = 4
set.termguicolors  = true
set.undofile       = true
set.updatetime     = 300
set.wrap           = false
set.writebackup    = false

-- disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.g.editorconfig       = 1

vim.cmd [[
set whichwrap+=<>,[,],h,l
set iskeyword+=-
set formatoptions-=cro
set lcs+=space:.
let g:loaded_python3_provider = 1
let g:loaded_node_provider = 1
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
]]

local augterm = vim.api.nvim_create_augroup("term", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = augterm,
    callback = function()
        vim.cmd [[
        tnoremap <buffer> <Esc> <c-\><c-n>
        startinsert
        setlocal nonumber
        setlocal norelativenumber
        ]]
    end
})
