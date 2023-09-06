local lsp = require("lsp-zero")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
lsp.preset("recommended")
lsp.ensure_installed({
    "dockerls",
    "graphql",
    "jedi_language_server",
    "jsonls",
    "kotlin_language_server",
    "lua_ls",
    "rust_analyzer",
    "terraformls",
    "tflint",
    "tsserver",
    "yamlls",
})

-- We'll use rust-tools to setup the rust-analyzer
lsp.skip_server_setup({ "rust_analyzer", "jdtls", "eslint" })

lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                global = "vim"
            }
        }
    }
})

lsp.configure("jsonls", {
    settings = {
        http = {
            proxyStrictSSL = false
        }
    }
})

lsp.configure("yamlls", {
    settings = {
        http = {
            proxyStrictSSL = false
        },
        yaml = {
            hover = true,
            completion = true,
            keyOrdering = false,
            format = {
                enabled = true
            },
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json",
                enable = true,
            },
            schemas = {
                ["/Users/jjarsater/projects/payments-core/schemas/svcspec.json"] = { "tools/release-artifacts/spec.yaml",
                    "tools/release-artifacts/spec.yml" },
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
})


lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.nvim_workspace()
lsp.setup()

local cmp = require("cmp")
local sel = { behaviour = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "nvim_lsp",               keyword_length = 3 },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua",               keyword_length = 2 },
        { name = "buffer",                 keyword_length = 2 },
        { name = "path" },
        { name = "spell" },
        { name = "calc" },
    },
    mappings = {
        ["<C-p>"] = cmp.mapping.select_prev_item(sel),
        ["<C-n>"] = cmp.mapping.select_next_item(sel),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = nil,
        ["<C-Tab>"] = nil,
    }
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true
})

