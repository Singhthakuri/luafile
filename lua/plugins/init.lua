
return {
  -- Example plugin:
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  "kyazdani42/nvim-web-devicons",
  -- Add more plugins here
  {
    "neovim/nvim-lspconfig",
  },
{
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig"
  },
  opts = {}
},
  
}
