local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end


local kind_icons = {
	Text          = "",
	Method        = "m",
	Function      = "",
	Constructor   = "",
	Field         = "",
	Variable      = "",
	Class         = "",
	Interface     = "",
	Module        = "",
	Property      = "",
	Unit          = "",
	Value         = "",
	Enum          = "",
	Keyword       = "",
	Snippet       = "",
	Color         = "",
	File          = "",
	Reference     = "",
	Folder        = "",
	EnumMember    = "",
	Constant      = "",
	Struct        = "",
	Event         = "",
	Operator      = "",
	TypeParameter = "",
}


cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion    = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
    { name = "cmp_tabnine" },
		{ name = "path" },
		{ name = "calc" },
	}, {
 		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-k>"]     = cmp.mapping.select_prev_item(),
		["<C-j>"]     = cmp.mapping.select_next_item(),
		["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"]     = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"]     = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<CR>"]      = cmp.mapping.confirm { select = true },
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp        = "[LSP]",
        cmp_tabnine     = "[TN]",
				luasnip         = "[Snippet]",
				buffer          = "[Buffer]",
				path            = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	}
})