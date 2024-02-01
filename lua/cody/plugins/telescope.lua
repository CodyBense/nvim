return {
    'nvim-telescope/telescope.nvim', 

    tag = '0.1.5',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n' , '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
    -- keys = {
    --     { "<leader>pf", "<cmd>Telescope find_files<cr>" , desc = "Find files (project dir)" },
    --     { "<C-p>", "<cmd>Telescope git_files<cr>" , desc = "Find files (git dir)" },
    --     { "<leader>ps", "<cmd>Telescope grep_string<cr>" , desc = "Searches with a grep string" },
    -- }
}
