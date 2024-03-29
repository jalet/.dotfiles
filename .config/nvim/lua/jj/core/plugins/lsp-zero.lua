return {
    "VonHeikemen/lsp-zero.nvim",
    config = function()
        local lsp = require("lsp-zero")

        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Replace the language servers listed here 
            -- with the ones you want to install
            ensure_installed = {"jdtls", "rust_analyzer"},
            handlers = {
              lsp.default_setup,
              lua_ls = function()
                local lua_opts = lsp.nvim_lua_ls()
                require('lspconfig').lua_ls.setup(lua_opts)
              end,
            },
        })

        -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        lsp.preset("recommended")

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
                json = {
                    schemas = {
                        {
                            fileMatch = {"taskdef.json"},
                            url = "https://ecs-intellisense.s3-us-west-2.amazonaws.com/task-definition/schema.json"
                        }
                    }
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
                        ["/Users/jjarsater/projects/payments-core/schemas/svcspec.json"] = {
                            "tools/release-artifacts/spec.yaml",
                            "tools/release-artifacts/spec.yml",
                        },
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

        lsp.configure("kotlin_language_server", {
            settings = {
                root_dir = { "settings.gradle", "settings.gradle.kts" }
            }
        })

        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)

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
    end,
    dependencies = {
        "neovim/nvim-lspconfig", -- Required
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",     -- Required
        "hrsh7th/cmp-nvim-lsp", -- Required
        "L3MON4D3/LuaSnip",     -- Required
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
    }
}
