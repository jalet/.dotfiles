local set = vim.opt

set.backup              = false                              -- creates a backup file
set.ch                  = 0                                              -- command height
set.clipboard           = "unnamedplus"                      -- allows neovim to access the system clipboard
set.cmdheight           = 2                                  -- more space in the neovim command line for displaying messages
set.colorcolumn         = "+1"                               -- comma-separated list of screen columns that are highlighted
set.completeopt         = { "menuone", "noselect" }          -- mostly just for cmp
set.conceallevel        = 0                                  -- so that `` is visible in markdown files
set.cursorline          = true                               -- highlight the current line
set.expandtab			= true
set.fileencoding        = "utf-8"                            -- the encoding written to a file
set.guifont             = "monospace"                        -- the font used in graphical neovim applications
set.ignorecase          = true	                              -- ignore case in search patterns
set.list			    = false
set.ls                  = 0                                              -- last status
set.mouse               = "a"                                -- allow the mouse to be used in neovim
set.number              = true                               -- set numbered lines
set.numberwidth         = 4                                  -- set number column width to 2 {default 4}
set.pumheight           = 15                                 -- pop up menu height
set.relativenumber      = true                               -- set relative numbered lines
set.scrolloff           = 16                                 -- is one of my fav
set.shiftwidth          = 4                                  -- the number of spaces inserted for each indentation
set.showmode            = false                              -- we don"t need to see things like -- INSERT -- anymore
set.showtabline         = 2                                  -- always show tabs
set.sidescrolloff       = 8
set.signcolumn          = "yes"                              -- always show the sign column, otherwise it would shift the text each time
set.smartcase           = true                               -- smart case
set.smartindent         = true                               -- make indenting smarter again
set.spell               = true
set.spelllang           = { "en_gb", "en_us" }
set.splitbelow          = true                               -- force all horizontal splits to go below current window
set.splitright          = true                               -- force all vertical splits to go to the right of current window
set.swapfile            = false                              -- creates a swapfile
set.tabstop             = 4                                  -- insert 2 spaces for a tab
set.termguicolors       = true                               -- set term gui colors (most terminals support this)
set.undofile            = true                               -- enable persistent undo
set.updatetime          = 300                                -- faster completion (4000ms default)
set.wrap                = false                              -- display lines as one long line
set.writebackup         = false                              -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

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

