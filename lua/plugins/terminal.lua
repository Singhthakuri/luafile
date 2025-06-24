return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    -- Main toggle terminal
    local main_term = Terminal:new({ direction = "horizontal", size = 12 })

    vim.keymap.set('n', '<space>t', function()
      main_term:toggle()
    end, { noremap = true, silent = true })

    -- Create new horizontal terminal (new split)
    vim.keymap.set('n', '<space>h', function()
      Terminal:new({ direction = "horizontal", size = 12 }):toggle()
    end, { noremap = true, silent = true })

    -- Create new vertical terminal (new split)
    vim.keymap.set('n', '<space>v', function()
      Terminal:new({ direction = "vertical", size = 80 }):toggle()
    end, { noremap = true, silent = true })

    -- In terminal mode: create new horizontal terminal with <space>n
    vim.api.nvim_set_keymap('t', '<space>n', [[<C-\><C-n>:lua require("toggleterm.terminal").Terminal:new({ direction = "horizontal", size = 12 }):toggle()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
-- Resize terminal horizontally (increase/decrease height)
vim.keymap.set('n', '<leader>+', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>-', ':resize -2<CR>', { noremap = true, silent = true })

-- Resize terminal vertically (increase/decrease width)
vim.keymap.set('n', '<leader>>', ':vertical resize +4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader><', ':vertical resize -4<CR>', { noremap = true, silent = true })
-- In terminal mode, pressing 'jk' quickly will leave terminal input mode and enter visual mode
vim.api.nvim_set_keymap('t', 'jk', [[<C-\><C-n>v]], { noremap = true, silent = true })
    -- Terminal navigation with Ctrl + h/j/k/l
    function _G.set_terminal_keymaps()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}

