local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then
    return
end


local rt_status_ok, rt = pcall(require, "rust-tools")
if not rt_status_ok then
    return
end


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
lsp.preset("recommended")
lsp.ensure_installed({
    "dockerls",
    "graphql",
    "jedi_language_server",
    "jsonls",
    "kotlin_language_server",
    "rome",
    "rust_analyzer",
    "lua_ls",
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


lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.nvim_workspace()
lsp.setup()

local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "nvim_lsp",               keyword_length = 3 },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua",               keyword_length = 2 },
        { name = "buffer",                 keyword_length = 2 },
        { name = "path" },
        { name = "spell" },
        { name = "vsnip" },
        { name = "calc" },
    }
})
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true
})

local rustlsp = lsp.build_options("rust_analyzer", {
    single_file_support = false,
    on_attach = function(client, bufnr)
        local set = function(mode, sequence, action)
            vim.keymap.set(mode, sequence, action, { buffer = bufnr, remap = false })
        end

        on_attach(client, bufnr)
        set("n", "K", rt.hover_actions.hover_actions)
        set("n", "<leader>vca", rt.code_action_group.code_action_group)
    end,
})

rt.setup({
    server = rustlsp,
    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "codelldb",
            name = "rust",
            port = 9229,
        },
    },
})
rt.runnables.runnables()
