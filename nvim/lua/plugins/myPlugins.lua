return {
  -- Add catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "latte",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = true,
        mason = true,
        which_key = true,
      },
    },
  },

  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Rainbow indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        -- tab_char removed - use listchars setting instead
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
    config = function(_, opts)
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")

      -- Create the highlight groups with high contrast colors for latte theme
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#D20F39" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#DF8E1D" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1e66f5" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FE640B" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#40A02B" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8839EF" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#179299" })
      end)

      opts.indent.highlight = highlight
      opts.scope.highlight = highlight

      require("ibl").setup(opts)
    end,
  },

  -- Sticky context - shows function/class names at top
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 3, -- How many lines the window should span
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor", -- Line used to calculate context. 'cursor' or 'topline'
      separator = nil, -- Character to use as separator
      zindex = 20,
    },
    keys = {
      {
        "<leader>ut",
        "<cmd>TSContextToggle<cr>",
        desc = "Toggle Treesitter Context",
      },
    },
  },

  -- Enhanced lualine with filename modified indicator
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Customize filename component to show modified indicator
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}

      -- Add filename with modified indicator
      table.insert(opts.sections.lualine_c, {
        "filename",
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        symbols = {
          modified = " ●", -- Text to show when modified
          readonly = " ", -- Text to show when readonly
          unnamed = "[No Name]",
        },
      })

      return opts
    end,
  },

  -- Disable markdownlint warnings
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Disable markdownlint for markdown files
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}

      return opts
    end,
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
      })
    end,
  },

  -- Customize blink.cmp keybindings
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Enter always inserts newline (don't accept suggestion)
        ["<CR>"] = {},
        -- Ctrl+Enter accepts the suggestion
        ["<C-CR>"] = { "accept", "fallback" },
      },
    },
  },

  -- Python LSP with pyright - enable auto-imports from project subdirectories
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- Analyze all files in workspace
              },
            },
          },
        },
      },
    },
  },
}
