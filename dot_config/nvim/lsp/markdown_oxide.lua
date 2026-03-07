local capabilites = require("cmp_nvim_lsp").default_capabilities()
return {
  root_markers = { ".git", ".obsidian", ".moxide.toml" },
  cmd = { "markdown-oxide" },
  filetypes = { "md", "markdown" },
  capabilites = capabilites,
}
