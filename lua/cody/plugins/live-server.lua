return{
    'barrett-ruth/live-server.nvim',
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = function()
        vim.keymap.set('n', '<leader>l', vim.cmd.LiveServerStart)
        vim.keymap.set('n', '<leader>ls', vim.cmd.LiveServerStop)
    end
}
