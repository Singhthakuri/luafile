-- Setup our JDTLS server any time we open up a java file
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'config.jdtls'.setup_jdtls()
    augroup end
]]


local timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("TextChanged", {
  pattern = "*",
  callback = function()
    timer:stop()
    timer:start(1000, 0, vim.schedule_wrap(function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.bo[buf].modifiable and vim.bo[buf].modified and vim.fn.expand("%:p") ~= "" and vim.bo[buf].buftype == "" then
        vim.cmd("silent! write")
        vim.notify("💾 Auto-saved (debounced): " .. vim.fn.expand("%:t"), vim.log.levels.INFO, { title = "AutoSave" })
      end
    end))
  end,
})

