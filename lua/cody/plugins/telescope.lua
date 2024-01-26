return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files<cr>" , desc = "Find files (project dir)" },
        { "<C-p>", "<cmd>Telescope git_files<cr>" , desc = "Find files (git dir)" },
        { "<leader>ps", "<cmd>Telescope grep_string<cr>" , desc = "Searches with a grep string" },
    }
}
