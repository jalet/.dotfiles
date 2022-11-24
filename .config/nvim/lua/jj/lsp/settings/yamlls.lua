return {
	yaml = {
        hover = true,
        completion = true,
        keyOrdering=false,
        format = {
            enabled = true
        },
		schemaStore = {
			url = "https://www.schemastore.org/api/json/catalog.json",
			enable = true,
		},
		schemas = {
			["/Users/jjarsater/projects/payments-core/schemas/svcspec.json"] = { "tools/release-artifacts/spec.yaml", "tools/release-artifacts/spec.yml" },
			["https://json.schemastore.org/github-workflow.json"] = { "/.github/workflows/*" },
			["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = {
				"*/cloudformation/*",
                "*/stacksets/*",
			},
		},
        customTags = {
            "!fn",
            "!And",
            "!If",
            "!Not",
            "!Equals",
            "!Or",
            "!FindInMap sequence",
            "!Base64",
            "!Cidr",
            "!Ref",
            "!Ref Scalar",
            "!Sub",
            "!GetAtt",
            "!GetAZs",
            "!ImportValue",
            "!Select",
            "!Split",
            "!Join sequence"
        },
	},
}
