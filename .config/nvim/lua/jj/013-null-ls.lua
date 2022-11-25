local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local a = null_ls.builtins.code_actions
local c = null_ls.builtins.completion
local d = null_ls.builtins.diagnostics
local f = null_ls.builtins.formatting

null_ls.setup({
  debug = true,
  sources = {
    -- Spelling/Grammar
    c.spell,
    f.codespell,

    -- Lua
    f.stylua,

    -- Python
    f.black,
    d.flake8,

    -- Java
    -- Managed by jdtls,

    -- HCL (Terraform)
    f.terraform_fmt,

    -- Javascript/Typescript
    a.eslint,
    d.eslint,
    f.rome,
    f.jq,

    -- fish
    d.fish,
    f.fish_indent,
  }
})
