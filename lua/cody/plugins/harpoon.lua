return {
    'ThePrimeagen/harpoon',
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = true,
    keys = {
        { "<leader>a", "<cmd> lua require('harpoon.mark').add_file()<cr>", desc = "Mark file"},
        { "<C-e>", "<cmd> lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle quick menu"},
        { "<C-h>", "<cmd> lua require('harpoon.ui').nav_file(1)<cr>", desc = "Switch to first file"},
        { "<C-t>", "<cmd> lua require('harpoon.ui').nav_file(2)<cr>", desc = "Switch to second file"},
        { "<C-n>", "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", desc = "Switch to thrid file"},
        { "<C-s>", "<cmd> lua require('harpoon.ui').nav_file(4)<cr>", desc = "Switch to fourth file"},
    }
}
