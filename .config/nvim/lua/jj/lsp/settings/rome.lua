return {
	json = {
		schemas = {
			{
				description = "TypeScript compiler configuration file",
				fileMatch = { "tsconfig.json", "tsconfig.*.json" },
				url = "http://json.schemastore.org/tsconfig",
			},
			{
				description = "Lerna config",
				fileMatch = { "lerna.json" },
				url = "http://json.schemastore.org/lerna",
			},
			{
				description = "Babel configuration",
				fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
				url = "http://json.schemastore.org/lerna",
			},
			{
				description = "ESLint config",
				fileMatch = { ".eslintrc.json", ".eslintrc" },
				url = "http://json.schemastore.org/eslintrc",
			},
			{
				description = "Prettier config",
				fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
				url = "http://json.schemastore.org/prettierrc",
			},
			{
				description = "Stylelint config",
				fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
				url = "http://json.schemastore.org/stylelintrc",
			},
		},
	},
}