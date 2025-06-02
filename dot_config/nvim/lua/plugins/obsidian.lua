return {
	{
		"obsidian-nvim/obsidian.nvim",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"MeanderingProgrammer/render-markdown.nvim",

			-- see above for full list of optional dependencies ☝️
		},
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
			},
			notes_subdir = "notes",

			-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
			-- levels defined by "vim.log.levels.\*".
			log_level = vim.log.levels.INFO,

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				-- Enables completion using nvim_cmp
				nvim_cmp = true,
				-- Enables completion using blink.cmp
				blink = false,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},

			-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
			-- way then set 'mappings = {}'.
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context: follow link, show notes with tag, toggle checkbox, or toggle heading fold
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},

			-- Where to put new notes. Valid options are
			-- _ "current_dir" - put new notes in same directory as the current buffer.
			-- _ "notes_subdir" - put new notes in the default notes subdirectory.
			new_notes_location = "notes_subdir",

			-- Optional, customize how wiki links are formatted. You can set this to one of:
			-- _ "use_alias_only", e.g. '[[Foo Bar]]'
			-- _ "prepend*note_id", e.g. '[[foo-bar|Foo Bar]]'
			-- * "prepend*note_path", e.g. '[[foo-bar.md|Foo Bar]]'
			-- * "use_path_only", e.g. '[[foo-bar.md]]'
			-- Or you can set it to a function that takes a table of options and returns a string, like this:
			wiki_link_func = function(opts)
				return require("obsidian.util").wiki_link_id_prefix(opts)
			end,

			-- Optional, customize how markdown links are formatted.
			markdown_link_func = function(opts)
				return require("obsidian.util").markdown_link(opts)
			end,

			-- Either 'wiki' or 'markdown'.
			preferred_link_style = "wiki",

			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = false,

			-- Optional, alternatively you can customize the frontmatter data.
			-- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)

			-- Sets how you follow URLs
			---@param url string
			follow_url_func = function(url)
				vim.ui.open(url)
				vim.ui.open(url, { cmd = { "zen-browser" } })
			end,

			-- Sets how you follow images
			---@param img string
			follow_img_func = function(img)
				vim.ui.open(img)
				-- vim.ui.open(img, { cmd = { "loupe" } })
			end,

			-- Optional, set to true if you use the Obsidian Advanced URI plugin.
			-- https://github.com/Vinzent03/obsidian-advanced-uri
			use_advanced_uri = false,

			-- Optional, set to true to force ':Obsidian open' to bring the app to the foreground.
			open_app_foreground = false,

			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
				name = "telescope.nvim",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},

			-- Optional, sort search results by "path", "modified", "accessed", or "created".
			-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
			-- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
			sort_by = "modified",
			sort_reversed = true,

			-- Set the maximum number of lines to read from notes on disk when performing certain searches.
			search_max_lines = 1000,

			-- Optional, determines how certain commands open notes. The valid options are:
			-- 1. "current" (the default) - to always open in the current window
			-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
			-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
			open_notes_in = "current",

			-- Optional, define your own callbacks to further customize behavior.
			-- Optional, configure additional syntax highlighting / extmarks.
			-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
			ui = {
				enable = true, -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				max_file_length = 5000, -- disable UI features for files with more than this many lines
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
					-- Replace the above with this if you don't have a patched font:
					-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

					-- You can also add more custom ones...
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianImportant = { bold = true, fg = "#d73128" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},

			-- Specify how to handle attachments.
			attachments = {
				-- The default folder to place images in via `:Obsidian paste_img`.
				-- If this is a relative path it will be interpreted as relative to the vault root.
				-- You can always override this per image by passing a full path to the command instead of just a filename.
				img_folder = "assets/imgs", -- This is the default

				-- A function that determines default name or prefix when pasting images via `:Obsidian paste_img`.
				---@return string
				img_name_func = function()
					-- Prefix image names with timestamp.
					return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
				end,

				-- A function that determines the text to insert in the note when pasting an image.
				-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
				-- This is the default implementation.
				---@param client obsidian.Client
				---@param path obsidian.Path the absolute path to the image file
				---@return string
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},

			-- See https://github.com/obsidian-nvim/obsidian.nvim/wiki/Notes-on-configuration#statusline-component
			statusline = {
				enabled = true,
				format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
			},
		},
		config = function(opts)
			require("obsidian").setup(opts)
		end,
	},
}


