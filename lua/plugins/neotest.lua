-- Test framework

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'mfussenegger/nvim-dap',

    -- Runners
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      log_level = vim.log.levels.DEBUG,
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false, logToFile = true },
          runner = 'pytest',
          args = { '--log-level', 'DEBUG', '--cov=svr/', '-o', "addopts=''" },
        },
      },
    }
    vim.keymap.set('n', '<leader>tdn', function()
      require('neotest').run.run { strategy = 'dap', suite = false }
    end, { silent = true, desc = '[T]est [D]ebug [N]: Nearest' })

    vim.keymap.set('n', '<leader>tdt', function()
      require('neotest').run.run { vim.fn.expand '%', strategy = 'dap', suite = false }
    end, { silent = true, desc = '[T]est [D]ebug [F]ile' })

    vim.keymap.set('n', '<leader>tdl', function()
      require('neotest').run.run_last { strategy = 'dap', suite = false }
    end, { silent = true, desc = '[T]est [D]ebug [L]ast' })

    vim.keymap.set('n', '<leader>tn', function()
      require('neotest').run.run()
    end, { silent = true, desc = '[T]est [N]earest' })

    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run { vim.fn.expand '%', suite = false }
      print 'hello world'
    end, { silent = true, desc = '[T]est [F]ile' })

    vim.keymap.set('n', '<leader>ta', function()
      require('neotest').run.run { suite = true }
    end, { silent = true, desc = '[T]est [A]ll' })

    vim.keymap.set('n', '<leader>tl', function()
      require('neotest').run.run_last()
    end, { silent = true, desc = '[T]est [L]ast' })
  end,
}
