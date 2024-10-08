-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--         "hrsh7th/nvim-cmp",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--         "j-hui/fidget.nvim",
--     },
--
--     config = function()
--         local cmp = require('cmp')
--         local cmp_lsp = require("cmp_nvim_lsp")
--         local capabilities = vim.tbl_deep_extend(
--             "force",
--             {},
--             vim.lsp.protocol.make_client_capabilities(),
--             cmp_lsp.default_capabilities())
--
--         require("fidget").setup({})
--         require("mason").setup()
--         require("mason-lspconfig").setup({
--             ensure_install = {
--                 "lua_ls",
--                 "rust_analyzer",
--                 "tsserver",
--             },
--             handlers = {
--                 function(server_name)
--
--                     require("lspconfig")[server_name].setup{
--                         capabilities = capabilities
--                     }
--                 end,
--
--                 ["lua_ls"] = function()
--                     local lspconfig = require("lspconfig")
--                     lspconfig.lua_ls.setup {
--                         capabilities = capabilities,
--                         settings = {
--                             Lua = {
--                                 diagnostics = {
--                                     globals = { "vim", "it", "describe", "before_each", "after_each" },
--                                 }
--                             }
--                         }
--                     }
--                 end,
--             }
--         })
--
--         local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
--         cmp.setup({
--             snippet = {
--                 expand = function(args)
--                     require('lspsnip').lsp_expand(args.body)
--                 end,
--             },
--             mapping = cmp.mapping.preset.insert({
--                 ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--                 ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--                 ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--                 ["<C-space>"] = cmp.mapping.complete(),
--             }),
--             sources = cmp.config.sources({
--                 { name = 'nvim_lsp' },
--                 { name = 'luasnip' },
--             }, {
--                 { name = 'buffer' },
--             })
--         })
--
--         vim.diagnostic.config({
--             float = {
--                 focusable = false,
--                 style = "minimal",
--                 border = "rounded",
--                 source = "always",
--                 header = "",
--                 prefix = "",
--             },
--         })
--     end
-- }
return{
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
                    -- 'tsserver',
                    -- 'eslint',
                    -- 'pyright',
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    }
}
