return {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
        vim.cmd.colorscheme("gruvbox")
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
    end
}
