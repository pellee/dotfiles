require("config.lazy")

vim.diagnostic.config({
   virtual_lines = true,
  -- virtual_text = true,
  -- virtual_text = { current_line = true },
})

vim.lsp.enable({
  "lua_ls",
})
