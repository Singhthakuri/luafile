
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local icons = require("config.icons")

      -- Define highlight groups to fix deprecation warnings
      vim.api.nvim_set_hl(0, 'GitSignsAdd',         { link = 'DiffAdd' })
      vim.api.nvim_set_hl(0, 'GitSignsAddLn',       { link = 'DiffAdd' })
      vim.api.nvim_set_hl(0, 'GitSignsAddNr',       { link = 'DiffAdd' })
      vim.api.nvim_set_hl(0, 'GitSignsChange',      { link = 'DiffChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeLn',    { link = 'DiffChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeNr',    { link = 'DiffChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangedelete',    { link = 'DiffChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn',  { link = 'DiffChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr',  { link = 'DiffChange' })

      require("gitsigns").setup({
        signs = {
          add = {
            text = icons.ui.BoldLineMiddle,
          },
          change = {
            text = icons.ui.BoldLineDashedMiddle,
          },
          changedelete = {
            text = icons.ui.BoldLineCross,
          },
        },
      })
    end,
  },
}
