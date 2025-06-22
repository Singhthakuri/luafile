
-- lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      size = 12,
      start_in_insert = true,
      open_mapping = [[<C-\>]],
      shade_terminals = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      close_on_exit = true,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    -- Toggle default terminal (Space + t)
    vim.keymap.set('n', '<leader>t', function()
      require("toggleterm").toggle(1)
    end, { noremap = true, silent = true })

    -- New terminal (Space + n)
    vim.keymap.set('n', '<leader>n', function()
      Terminal:new({ direction = "horizontal" }):toggle()
    end, { noremap = true, silent = true })

    -- Horizontal terminal (Space + h)
    vim.keymap.set('n', '<leader>h', function()
      Terminal:new({ direction = "horizontal", size = 12 }):toggle()
    end, { noremap = true, silent = true })

    -- Vertical terminal (Space + v)
    vim.keymap.set('n', '<leader>v', function()
      Terminal:new({ direction = "vertical", size = 60 }):toggle()
    end, { noremap = true, silent = true })

    -- Save & Quit (Space + w)
    vim.keymap.set('n', '<leader>w', ':wq<CR>', { noremap = true, silent = true })

    -- Quit (Space + q)
    vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

    -- Terminal navigation with Ctrl + h/j/k/l
    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}
