return {
  'andythigpen/nvim-coverage',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local coverage = require 'coverage'
    local show_coverage = false

    local function toggle_coverage(_)
      show_coverage = not show_coverage
      coverage.load(show_coverage)
    end

    local function load_cb()
      if show_coverage then
        coverage.show()
      else
        coverage.hide()
      end
    end

    coverage.setup {
      auto_reload = true,
      load_coverage_cb = load_cb,
      lang = {
        python = {
          coverage_file = '.coverage',
          coverage_command = 'coverage json --fail-under=0 -q -o -',
          only_open_buffers = false,
        },
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'python',
      desc = 'Auto-load coverage in python projects',
      callback = coverage.load,
    })

    vim.api.nvim_set_keymap('n', '<leader>cs', '<CMD>:CoverageSummary<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>cv', '', { noremap = true, callback = toggle_coverage })
  end,
}
