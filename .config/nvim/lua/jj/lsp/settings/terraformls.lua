-- Format on save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern  = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format({ async = true })
  end
})

return {}
