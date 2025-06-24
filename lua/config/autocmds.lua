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


-- Keep your existing JDTLS setup
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'config.jdtls'.setup_jdtls()
    augroup end
]]

-- Improved auto-save with better MERN stack support
local auto_save_timer = vim.loop.new_timer()
local auto_save_group = vim.api.nvim_create_augroup("MERN_AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufLeave" }, {
  group = auto_save_group,
  pattern = {
    "*.js", "*.jsx", "*.ts", "*.tsx",  -- JavaScript/TypeScript
    "*.java",                           -- Java
    "*.json",                           -- package.json/config files
    "*.html", "*.css", "*.scss"         -- Frontend files
  },
  callback = function()
    auto_save_timer:stop()
    auto_save_timer:start(1500, 0, vim.schedule_wrap(function()
      local buf = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[buf].filetype
      
      -- Only save if conditions are met
      if vim.bo[buf].modifiable and 
         vim.bo[buf].modified and 
         vim.fn.expand("%:p") ~= "" and 
         vim.bo[buf].buftype == "" then
        
        -- Skip auto-save during Git operations
        if filetype == "gitcommit" or filetype == "gitrebase" then
          return
        end
        
        vim.cmd("silent! write")
        
        -- Only notify for non-Java files to reduce noise
        if filetype ~= "java" then
          vim.notify("💾 Auto-saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO, {
            title = "AutoSave",
            icon = "",
            timeout = 500
          })
        end
      end
    end))
  end,
})

-- Format on save for all supported filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
  group = auto_save_group,
  pattern = {
    "*.js", "*.jsx", "*.ts", "*.tsx",
    "*.java",
    "*.json",
    "*.html", "*.css", "*.scss"
  },
  callback = function()
    -- Use LSP formatting if available, otherwise fallback to Prettier
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    else
      vim.cmd("Prettier")
    end
  end,
})
