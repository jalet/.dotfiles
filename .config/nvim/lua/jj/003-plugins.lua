local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup("jj.core.plugins")

-- -- Scaffolding
--
-- -- Colorschemes
--
-- -- Zero
-- use({
-- ,
-- requires = {
-- -- LSP
--
-- -- CMP
--
-- -- Other
-- { "L3MON4D3/LuaSnip" },
-- { "simrat39/rust-tools.nvim" },
-- }
-- })
--
-- -- DAP and Testing
-- use("mfussenegger/nvim-dap")
-- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
-- use("nvim-telescope/telescope-dap.nvim")
-- use("vim-test/vim-test")
--
-- -- My Plugins
-- use("hashivim/vim-terraform")
-- use()
-- use("RRethy/nvim-align")
-- use(")
-- use()
-- use("junegunn/vim-easy-align")
-- use()
--
