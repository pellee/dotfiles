require("config.lazy")

vim.diagnostic.config({
	virtual_lines = true,
	-- virtual_text = true,
	-- virtual_text = { current_line = true },
})

vim.lsp.enable({
	"lua_ls",
	"markdown_oxide",
})

vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
