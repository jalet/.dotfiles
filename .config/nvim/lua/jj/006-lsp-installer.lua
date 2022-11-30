local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"jdtls",
		"rust_analyzer",
		"sumneko_lua",
		"terraformls",
		"tflint",
		"tsserver",
        "graphql",
        "kotlin_language_server",
        "rome",
	},
})
