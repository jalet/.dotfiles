require("nvim-tree").setup({
	view = {
		side = "left",
		number = true,
		relativenumber = true,
	},
	renderer = {
		add_trailing = true,
		group_empty = true,
	},
	filters = {
		dotfiles = false,
		custom = {
			"^.idea$", -- IntelliJ Idea
			"^.settings$", -- IntelliJ Settings
			"^.git$", -- git
		},
	},
	git = {
		enable = false,
		ignore = false,
		show_on_dirs = true,
		timeout = 400,
	},
})
