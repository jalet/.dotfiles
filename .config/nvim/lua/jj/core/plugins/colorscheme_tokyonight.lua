return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
        vim.cmd.colorscheme("tokyonight")
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
    end
}

