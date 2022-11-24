vim.filetype.add({
	extension = {
		tf      = 'terraform',
		tfvars  = 'terraform',
		tfstate = 'json',
	},
	pattern = {
		['*.json.tpl'] = 'json',
	},
})

