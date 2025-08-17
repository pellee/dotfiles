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
    config = function()
      require("obsidian").setup({
        legacy_commands = false,
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
        new_notes_location = "notes_subdir",

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
        checkbox = {
          order = { " ", "x", ">", "<", "-", "!", "?", "/", "I", "f", '"', "p", "c" },
        },
        -- You can also add more custom ones...
        -- Optional, define your own callbacks to further customize behavior.
        -- Optional, configure additional syntax highlighting / extmarks.
        -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
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
      })
    end,
  },
}
