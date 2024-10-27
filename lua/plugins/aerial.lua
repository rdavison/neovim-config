-- NOTE: Why did I have this configured twice?
--
-- {
--     'stevearc/aerial.nvim',
--     opts = {
--       -- Enable aerial on these filetypes
--       filetypes = { 'python', 'typescript', 'typescriptreact' },
--
--       -- How to show aerial, can be 'right', 'left', or 'float'
--       default_direction = 'left',
--
--       -- Automatically open aerial when entering a buffer
--       open_automatic = false,
--
--       -- Update aerial when these events are triggered
--       update_events = 'TextChanged,InsertLeave',
--
--       -- List of treesitter symbols or LSP symbols to show
--       backends = { 'treesitter', 'lsp' },
--
--       -- Enable for specific programming languages
--       filter_kind = {
--         -- Python symbols to show
--         python = {
--           'Class',
--           'Function',
--           'Method',
--           'Module',
--           'Variable',
--         },
--         -- TypeScript symbols to show
--         typescript = {
--           'Class',
--           'Function',
--           'Method',
--           'Interface',
--           'Variable',
--         },
--       },
--
--       -- Show line numbers next to the symbols
--       show_line_numbers = true,
--
--       -- Keybindings for quick navigation
--       keymaps = {
--         ['<leader><Tab>'] = 'aerial.toggle!',
--         ['{'] = 'aerial.prev',
--         ['}'] = 'aerial.next',
--       },
--     },
--     -- Optional dependencies
--     dependencies = {
--       'nvim-treesitter/nvim-treesitter',
--       'nvim-tree/nvim-web-devicons',
--     },
--   }

return {
  'stevearc/aerial.nvim',
  config = function(_, opts)
    require('aerial').setup {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    }

    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
  end,
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
