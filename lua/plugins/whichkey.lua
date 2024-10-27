return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', desc = '[C]ode' },
      { '<leader>c_', hidden = true },
      { '<leader>d', desc = '[D]ocument' },
      { '<leader>d_', hidden = true },
      { '<leader>r', desc = '[R]ename' },
      { '<leader>r_', hidden = true },
      { '<leader>s', desc = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>w', desc = '[W]orkspace' },
      { '<leader>w_', hidden = true },
      { '<leader>t', desc = '[T]oggle' },
      { '<leader>t_', hidden = true },
      { '<leader>h', desc = 'Git [H]unk' },
      { '<leader>h_', hidden = true },
    }
    -- visual mode
    require('which-key').add {
      { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
    }
  end,
}
