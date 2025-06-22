return {
  -- Dracula colorscheme
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
        italic_comment = true,
        lualine_bg_color = "#44475a",
      })
      vim.cmd("colorscheme dracula")
    end,
  },

  -- Material Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  -- Lualine status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
          icons_enabled = true,
          section_separators = "",
          component_separators = "|",
        },
      })
    end,
  },
}
