local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then
    return
end


local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
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
lsp.skip_server_setup({ "rust_analyzer" })

lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                global = "vim"
            }
        }
    }
})

lsp.configure("yamlls", {
    settings = {
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


local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

local on_attach = function(client, bufnr)
    local set = function(mode, sequence, action)
        vim.keymap.set(mode, sequence, action, { buffer = bufnr, remap = false })
    end

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    set("n", "gd", vim.lsp.buf.definition)
    set("n", "K", vim.lsp.buf.hover)
    set("n", "F", ":LspZeroFormat<cr>")
    set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
    set("n", "<leader>vd", vim.diagnostic.open_float)
    set("n", "[d", vim.diagnostic.goto_next)
    set("n", "]d", vim.diagnostic.goto_prev)
    set("n", "<leader>vca", vim.lsp.buf.code_action)
    set("n", "<leader>vrr", vim.lsp.buf.references)
    set("n", "<leader>vrn", vim.lsp.buf.rename)
    set("i", "<C-h>", vim.lsp.buf.signature_help)
end

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp',               keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua',               keyword_length = 2 },
        { name = 'buffer',                 keyword_length = 2 },
        { name = "vsnip" },
        { name = 'calc' },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
})

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(on_attach)
lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
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
