-- Set our leader keybinding to space
-- Anywhere you see <leader> in a keymapping specifies the space key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--neovim
-- ONLY set <leader>e if NOT in VSCode
if vim.g.vscode then
  local sidebar_open = false

  vim.keymap.set("n", "<leader>e", function()
    if sidebar_open then
      vim.fn.VSCodeNotify("workbench.action.toggleSidebarVisibility")
      sidebar_open = false
    else
      vim.fn.VSCodeNotify("workbench.view.explorer")
      vim.defer_fn(function()
        vim.fn.VSCodeNotify("workbench.action.focusSideBar")
      end, 100)
      sidebar_open = true
    end
  end, { noremap = true, silent = true, desc = "Toggle VSCode Explorer" })
end


-- Remove search highlights after searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit Vim's terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- OPTIONAL: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>tc", ":tabnew<cr>", {desc = "[T]ab [C]reat New"})
vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", {desc = "[T]ab [N]ext"})
vim.keymap.set("n", "<leader>tp", ":tabprevious<cr>", {desc = "[T]ab [P]revious"})

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })


-- Save file using Ctrl+S
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- Quit file using Ctrl+Q
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })

-- Toggle between workspaces using Ctrl+h/j/k/l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

 -- to insert mode using jk 
-- 
-- Map 'jk' to exit insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode with jk" })


vim.keymap.set("n", "<leader>t", ":terminal<CR>", { noremap = true, silent = true, desc = "Open terminal" })
-- selecting the highlight text 
vim.keymap.set('n', '<CR>', 'viw', { noremap = true, silent = true, desc = "Select word under cursor" })
 ---navigation 
 -- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to window below" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to window above" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window" })

--using  space to split the window
-- Split window horizontally with <leader>h
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = "Horizontal split" })

-- Split window vertically with <leader>v
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = "Vertical split" })
--- for sizing the windows
-- Maximize current window (close others)
vim.keymap.set('n', '<leader>m', ':only<CR>', { desc = "Maximize current window" })

-- Equalize splits
vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = "Equalize window sizes" })

-- Resize window manually
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = "Shrink window height" })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = "Increase window height" })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = "Shrink window width" })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = "Increase window width" })
--terminal 
vim.keymap.set('n', '<leader>t', ':belowright split | terminal<CR>', { desc = "Open terminal at bottom" })
