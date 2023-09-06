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
require("lazy").setup({
    "nvim-lua/popup.nvim",   -- Popup API from Vim in Neovim
    "nvim-lua/plenary.nvim",  -- Lua functions toolbox, used by many plugins
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

    -- Color schemes
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox")
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
        end
    },

    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        require("jj.treesitter")
    end,

    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        config = function ()
            require("jj.lsp")
        end,
        dependencies = {
            "neovim/nvim-lspconfig",                -- Required
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",                     -- Required
            "hrsh7th/cmp-nvim-lsp",                 -- Required
            "L3MON4D3/LuaSnip",                     -- Required
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
        }
    },

    -- Other
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    { "mbbill/undotree", event = "VeryLazy" },
    {
        "gpanders/editorconfig.nvim",
        config = function()
            -- require("jj.editorconfig")
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("jj.gitsigns")
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    }
})

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
-- use("mzlogin/vim-markdown-toc")
-- use()
-- use("junegunn/vim-easy-align")
-- use("mfussenegger/nvim-jdtls")
--
