local capabilites = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { "clangd", "--background-index" },
  root_markers = { "compile_commands.json", "compile_flags.txt" },
  filetypes = { "c", "cpp" },
  capabilites = capabilites,
}
