return {
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")

		none_ls.setup({
			sources = {
				none_ls.builtins.formatting.stylua,
				none_ls.builtins.formatting.clang_format,
				none_ls.builtins.diagnostics.cppcheck,
				none_ls.builtins.diagnostics.staticcheck,
				none_ls.builtins.formatting.gofumpt,
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
