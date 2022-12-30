-- Short hand function name
local fn  = function(m, b, c)
    vim.api.nvim_set_keymap(m, b, c, { noremap = true, silent = true })
end

-- Remap space as leader key
fn("", "<Space>", "<Nop>")
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

-- Window navigation
fn("n", "<C-h>", "<C-w>h")
fn("n", "<C-j>", "<C-w>j")
fn("n", "<C-k>", "<C-w>k")
fn("n", "<C-l>", "<C-w>l")

-- Resize with arrows
fn("n", "<S-Up>", ":resize -2<cr>")
fn("n", "<S-Down>", ":resize +2<cr>")
fn("n", "<S-Left>", ":vertical resize +2<cr>")
fn("n", "<S-Right>", ":vertical resize -2<cr>")

-- Navigate buffers
fn("n", "<S-l>", ":bnext<cr>")
fn("n", "<S-h>", ":bprevious<cr>")
fn("n", "<S-d>", ":bdelete<cr>")

-- Insert --
-- Press jk fast to enter
fn("i", "jk", "<ESC>")

-- Visual ----------------------------------------------------------------------
-- Stay in indent mode

fn("v", "<", "<gv")
fn("v", ">", ">gv")

-- Visual Block ----------------------------------------------------------------
-- Move text up and down
fn("x", "<S-j>", ":m+<cr>gv=gv")
fn("x", "<S-k>", ":m-2<cr>gv=gv")

-- Telescope -------------------------------------------------------------------

fn("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
fn("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
fn("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
fn("n", "<leader>ft", "<cmd>TodoTelescope<cr>")
fn("n", "z=", "<cmd>Telescope spell_suggest<cr>")

-- Misc ------------------------------------------------------------------------

fn("n", "<leader>gg", "<cmd>lua require'neogit'.open()<cr>")
fn("n", "<leader>e", ":NvimTreeToggle<cr>")

-- DAP -------------------------------------------------------------------------

fn("n", "<leader>dt", ":lua require'dap'.toggle_breakpoint()<cr>")
fn("n", "<leader>dT", ":lua require'dap'.clear_breakpoints()<cr>")
fn("n", "<leader>du", ":lua require'dapui'.toggle()<cr>")
fn("n", "<leader>dc", ":Telescope dap commands<cr>")
