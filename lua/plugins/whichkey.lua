

return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        local which_key = require('which-key')

        which_key.setup()

        -- Register group names and hide warnings using new format
        which_key.register({
            { "<leader>/", group = "Comments" },
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ebug" },
            { "<leader>e", group = "[E]xplorer" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>J", group = "[J]ava" },
            { "<leader>t", group = "[T]ab" },
            { "<leader>w", group = "[W]indow" },

            -- Optionally suppress warnings for unused sub-prefixes
            { "<leader>c_", hidden = true },
            { "<leader>d_", hidden = true },
            { "<leader>e_", hidden = true },
            { "<leader>f_", hidden = true },
            { "<leader>g_", hidden = true },
            { "<leader>J_", hidden = true },
            { "<leader>t_", hidden = true },
            { "<leader>w_", hidden = true },
            { "<leader>/_", hidden = true },
        })
    end
}
