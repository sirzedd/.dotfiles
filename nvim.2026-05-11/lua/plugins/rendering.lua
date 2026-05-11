-- lua/plugins/tools.lua
return {
  --show image
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
        },
      },
      --            processor = "magick_cli",
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = true },
      picker = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
    },
    config = function()
      require("snacks").setup({
        image = {
          resolve = function(path, src)
            local api = require("obsidian.api")
            if api.path_is_note(path) then
              return api.resolve_attachment_path(src)
            end
          end,
        },
      })
    end,
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      legacy_commands = false,
      ui = { enable = false },
      workspaces = { { name = "vault", path = "/Users/joshua.hendricks/files/docs" } }, -- Change to your vault
      completion = {
        nvim_cmp = true,
        min_chars = 1,
        blink = false,
      },
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        --		folder = "attachments/imgs", -- This is the default
        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
        end,
      },
      link_style = "wiki",
      note_id_func = function(title)
        return title
      end,
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    --    lazy = true,
    enabled = function()
      local max_filesize = 2 * 1024 * 1024 -- 2 MB
      local file = vim.fn.expand("%:p")
      return not (vim.fn.getfsize(file) > max_filesize)
      --     return false
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    opts = {
      file_types = { "markdown" },
      render_modes = { "n", "c", "t" },
    },
    config = function()
      require("render-markdown").setup({
        checkbox = {
          -- Turn on / off checkbox state rendering
          enabled = true,
          -- Determines how icons fill the available space:
          --  inline:  underlying text is concealed resulting in a left aligned icon
          --  overlay: result is left padded with spaces to hide any additional text
          position = "inline",
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked' 󰄱
            icon = "󰄱 ",
            -- Highlight for the unchecked icon
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked' 󰱒
            icon = "󰱒 ",
            -- Highligh for the checked icon
            highlight = "RenderMarkdownChecked",
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw':       Matched against the raw text of a 'shortcut_link'
          --   'rendered':  Replaces the 'raw' value when rendering
          --   'highlight': Highlight for the 'rendered' icon  [-]
          custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          },
        },
        bullet = {
          -- Turn on / off list bullet rendering
          enabled = true,
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { "●", "○", "◆", "◇" },
          -- Padding to add to the left of bullet point
          left_pad = 0,
          -- Padding to add to the right of bullet point
          right_pad = 0,
          -- Highlight for the bullet icon
          highlight = "RenderMarkdownBullet",
        },
      })
    end,
  },

  --Paste images
  {
    "HakonHarnes/img-clip.nvim",
    config = function()
      require("img-clip").setup({
        default = {
          dir_path = "attachment-images",
          relative_to_current_file = false,
          insert_mode_after_paste = false,
        },
        opts = {
          -- add options here
          -- or leave it empty to use the default settings
        },
        keys = {
          -- suggested keymap
          { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
      })
    end,
  },
}
