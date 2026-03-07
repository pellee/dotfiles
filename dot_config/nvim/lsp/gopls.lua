local capabilites = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  capabilites = capabilites,
}
