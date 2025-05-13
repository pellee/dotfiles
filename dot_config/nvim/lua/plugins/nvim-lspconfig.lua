return {
  "neovim/nvim-lspconfig",
  config = function()
    local lsp_conf = require("lspconfig")
    local capabilites = require("cmp_nvim_lsp").default_capabilities()

    lsp_conf.lua_ls.setup({
      capabilites = capabilites,
    })
    lsp_conf.markdown_oxide.setup({
      capabilites = capabilites,
    })
    lsp_conf.clangd.setup({
      capabilites = capabilites,
    })
    lsp_conf.gopls.setup({
      capabilites = capabilites,
    })

    vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
  end,
}
