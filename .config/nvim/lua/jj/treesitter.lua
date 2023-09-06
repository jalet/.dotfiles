local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
    "bash",
    "fish",
    "go",
    "hcl",
    "java",
    "javascript",
    "json",
    "json5",
    "python",
    "rust",
    "rust",
    "toml",
    "typescript",
    "yaml",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
