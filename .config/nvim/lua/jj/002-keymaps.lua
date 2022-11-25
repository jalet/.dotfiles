local gopts = { noremap = true, silent = true }   -- options

-- Short hand function name
local fn  = vim.api.nvim_set_keymap

-- Remap space as leader key
fn("", "<Space>", "<Nop>", gopts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

fn("n", "<Leader>e", ":NvimTreeToggle<cr>", gopts)

-- Window navigation
fn("n", "<C-h>", "<C-w>h", gopts)
fn("n", "<C-j>", "<C-w>j", gopts)
fn("n", "<C-k>", "<C-w>k", gopts)
fn("n", "<C-l>", "<C-w>l", gopts)

-- Resize with arrows
fn("n", "<S-Up>", ":resize -2<cr>", gopts)
fn("n", "<S-Down>", ":resize +2<cr>", gopts)
fn("n", "<S-Left>", ":vertical resize +2<cr>", gopts)
fn("n", "<S-Right>", ":vertical resize -2<cr>", gopts)

-- Navigate buffers
fn("n", "<S-l>", ":bnext<cr>", gopts)
fn("n", "<S-h>", ":bprevious<cr>", gopts)
fn("n", "<S-d>", ":bdelete<cr>", gopts)

-- Insert --
-- Press jk fast to enter
fn("i", "jk", "<ESC>", gopts)

-- Visual ----------------------------------------------------------------------
-- Stay in indent mode

fn("v", "<", "<gv", gopts)
fn("v", ">", ">gv", gopts)

-- Visual Block ----------------------------------------------------------------
-- Move text up and down
fn("x", "<S-j>", ":m+<cr>gv=gv", gopts)
fn("x", "<S-k>", ":m-2<cr>gv=gv", gopts)

-- Telescope -------------------------------------------------------------------

fn("n", "<leader>ff", "<cmd>Telescope find_files<cr>", gopts)
fn("n", "<leader>fb", "<cmd>Telescope buffers<cr>", gopts)
fn("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", gopts)
fn("n", "<leader>ft", "<cmd>TodoTelescope<cr>", gopts)
fn("n", "z=", "<cmd>Telescope spell_suggest<cr>", gopts)

-- Misc ------------------------------------------------------------------------

fn("n", "<leader>gg", "<cmd>lua require'neogit'.open()<cr>", gopts)


-- DAP -------------------------------------------------------------------------

fn("n", "<leader>dt", ":lua require'dap'.toggle_breakpoint()<cr>", gopts)
fn("n", "<leader>dT", ":lua require'dap'.clear_breakpoints()<cr>", gopts)
fn("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", gopts)
fn("n", "<leader>dc", ":Telescope dap commands<CR>", gopts)
