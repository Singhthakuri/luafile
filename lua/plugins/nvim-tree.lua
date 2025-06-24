return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local nvim_tree_api = require("nvim-tree.api")

    -- Custom on_attach with guaranteed proper folder handling
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Load default mappings (except <CR> which we'll handle specially)
      api.config.mappings.default_on_attach(bufnr)

      -- Completely prevent parent folder navigation
      vim.keymap.set("n", "<CR>", function()
        local node = api.tree.get_node_under_cursor()
        if not node then return end

        if node.type == "directory" then
          -- ONLY toggle expansion, never navigate
          if node.open then
            api.node.navigate.parent_close()
          else
            api.node.open.no_window_picker()
          end
        else
          -- Regular file opening
          api.node.open.edit()
        end
      end, opts("Safe Toggle/Open"))
    end

    -- Toggle keymap
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer" })

    -- Icons setup (keep your existing)
    local icons = {}
    pcall(function() icons = require("config.icons") end)

    require("nvim-tree").setup({
      on_attach = on_attach,
      hijack_netrw = true,
      
      -- CRITICAL ANTI-NAVIGATION SETTINGS
      sync_root_with_cwd = false,
      update_focused_file = {
        enable = true,
        update_root = false,  -- Must be false
        update_cwd = false,   -- Must be false
      },
      actions = {
        change_dir = {
          enable = false,    -- Must be false
          global = false,    -- Must be false
        },
      },

      -- Your existing view/renderer/diagnostics config
      view = {
        relativenumber = true,
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":t",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          glyphs = {
            default = icons.ui and icons.ui.Text or "",
            symlink = icons.ui and icons.ui.FileSymlink or "",
            bookmark = icons.ui and icons.ui.BookMark or "",
            folder = {
              arrow_closed = icons.ui and icons.ui.ChevronRight or "▶",
              arrow_open = icons.ui and icons.ui.ChevronShortDown or "▼",
              default = icons.ui and icons.ui.Folder or "",
              open = icons.ui and icons.ui.FolderOpen or "",
              empty = icons.ui and icons.ui.EmptyFolder or "",
              empty_open = icons.ui and icons.ui.EmptyFolderOpen or "",
              symlink = icons.ui and icons.ui.FolderSymlink or "",
              symlink_open = icons.ui and icons.ui.FolderOpen or "",
            },
            git = {
              unstaged = icons.git and icons.git.FileUnstaged or "✗",
              staged = icons.git and icons.git.FileStaged or "✓",
              unmerged = icons.git and icons.git.FileUnmerged or "",
              renamed = icons.git and icons.git.FileRenamed or "➜",
              untracked = icons.git and icons.git.FileUntracked or "★",
              deleted = icons.git and icons.git.FileDeleted or "",
              ignored = icons.git and icons.git.FileIgnored or "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = icons.diagnostics and icons.diagnostics.BoldHint or "",
          info = icons.diagnostics and icons.diagnostics.BoldInformation or "",
          warning = icons.diagnostics and icons.diagnostics.BoldWarning or "",
          error = icons.diagnostics and icons.diagnostics.BoldError or "",
        },
      },
    })
  end,
}
