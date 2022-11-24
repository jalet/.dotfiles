local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    return
end

telescope.load_extension("dap")

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
    return
end

dapui.setup({
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 60,
            position = "right",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
})

dap.configurations.rt_lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "rt_lldb",
}
