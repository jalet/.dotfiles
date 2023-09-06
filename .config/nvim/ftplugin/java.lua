local jdtls = require("jdtls")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local root_markers = { "gradlew", ".git" }
local root_dir = jdtls.setup.find_root(root_markers)
local home_dir = os.getenv("HOME")
local workspace_folder = home_dir .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local jdtls_path = home_dir .. "/.local/share/nvim/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local function get_config_dir()
    -- Unlike some other programming languages (e.g. JavaScript)
    -- lua considers 0 truthy!
    if vim.fn.has('linux') == 1 then
        return 'config_linux'
    elseif vim.fn.has('mac') == 1 then
        return 'config_mac'
    else
        return 'config_win'
    end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditSupport = true

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", ":lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>vd", ":lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", ":lua require'jdtls'.test_class()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dn", ":lua require'jdtls'.test_nearest_method()<CR>", opts)

    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls.setup.add_commands()
end

-- DAP
local bundles = {
    vim.fn.glob(
        home_dir .. "/personal/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    ),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home_dir .. "/personal/vscode-java-test/server/*.jar"), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    capabilities = capabilities,

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        home_dir .. "/.asdf/installs/java/openjdk-17/bin/java",
        -- home_dir .. "/.asdf/installs/java/openjdk-17/bin/java",
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- 💀
        "-jar", launcher_jar,

        -- 💀
        "-configuration", vim.fs.normalize(jdtls_path .. "/" .. get_config_dir()),
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        -- 💀
        -- See `data directory configuration` section in the README
        "-data", workspace_folder,
    },

    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {
                    -- "com.sun.*",
                    -- "io.micrometer.shaded.*",
                    -- "java.awt.*",
                    -- "jdk.*",
                    -- "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = home_dir .. "/.asdf/installs/java/openjdk-17/",
                    },
                    {
                        name = "JavaSE-18",
                        path = home_dir .. "/.asdf/installs/java/openjdk-18/",
                    },
                    {
                        name = "JavaSE-19",
                        path = home_dir .. "/.asdf/installs/java/openjdk-19/",
                    },
                    {
                        name = "JavaSE-20",
                        path = home_dir .. "/.asdf/installs/java/openjdk-20/",
                    },
                },
            },
            maven = {
                downloadSources = true,
            },
            eclipse = {
                downloadSources = true,
            },
            format = {
                settings = {
                    url = home_dir .. "/projects/izettle-documents/system/local/iZettle_profile.xml",
                },
            },
        },
    },

    init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = bundles,
    },
    on_attach = on_attach,
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
