-- lua/plugins/catppuccin.lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- load early so colorscheme is applied first
  config = function()
    -- setup options (optional)
    require("catppuccin").setup({
      flavour = "latte", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      show_end_of_buffer = true,
      integrations = {
        -- enable for popular plugins
        treesitter = true,
        telescope = true,
        lualine = true,
        mason = true,
        -- etc...
      },
    })

    -- apply the colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}
