return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = "2" } },
				lualine_b = {
					{ "filename", file_status = true, path = 1 },
				},
				lualine_c = {
					{ "branch", "diff", "diagnostics" ,
					separator = { right = "" },
					left_padding = "2", }
				},
				lualine_x = { "datetime" },
				lualine_y = { "location" },
				lualine_z = { { "progress", separator = { right = "" } } },
			},
			inactive_sections = {
				lualine_a = { { "filename", file_status = true, path = 1 } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
