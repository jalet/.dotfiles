local fn = vim.fn
local plugin_install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(plugin_install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		plugin_install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost 003-plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Scaffolding
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- Popup API from Vim in Neovim
	use("nvim-lua/plenary.nvim") -- Lua functions toolbox, used by many plugins
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("ellisonleao/gruvbox.nvim")

    -- Zero
    use({"VonHeikemen/lsp-zero.nvim", requires = {
        -- LSP
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- CMP
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
    }})

    -- DAP and Testing
	use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})
    use("nvim-telescope/telescope-dap.nvim")
    use("vim-test/vim-test")

	-- My Plugins
	use("hashivim/vim-terraform")
	use("gpanders/editorconfig.nvim")
	use("lewis6991/gitsigns.nvim")
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("RRethy/nvim-align")
	use("mzlogin/vim-markdown-toc")
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" })
    use("mbbill/undotree")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
