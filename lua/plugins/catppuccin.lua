-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  -- 'mikesmithgh/gruvsquirrel.nvim',
  -- 'DanisDGK/srcery.nvim',
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    local base = {
      red = '#ff657a',
      maroon = '#F29BA7',
      peach = '#ff9b5e',
      yellow = '#eccc81',
      green = '#a8be81',
      teal = '#9cd1bb',
      sky = '#A6C9E5',
      sapphire = '#86AACC',
      blue = '#5d81ab',
      lavender = '#66729C',
      mauve = '#b18eab',
    }

    local extend_base = function(value)
      return vim.tbl_extend('force', base, value)
    end

    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte',
      },
      -- color_overrides = {
      --   mocha = {
      --     text = '#F4CDE9',
      --     subtext1 = '#DEBAD4',
      --     subtext0 = '#C8A6BE',
      --     overlay2 = '#B293A8',
      --     overlay1 = '#9C7F92',
      --     overlay0 = '#866C7D',
      --     surface2 = '#705867',
      --     surface1 = '#5A4551',
      --     surface0 = '#44313B',
      --
      --     base = '#352939',
      --     mantle = '#211924',
      --     crust = '#1a1016',
      --   },
      --   latte = extend_base {
      --     text = '#202027',
      --     subtext1 = '#263168',
      --     subtext0 = '#4c4f69',
      --     overlay2 = '#737994',
      --     overlay1 = '#838ba7',
      --     base = '#fcfcfa',
      --     mantle = '#EAEDF3',
      --     crust = '#DCE0E8',
      --     pink = '#EA7A95',
      --     mauve = '#986794',
      --     red = '#EC5E66',
      --     peach = '#FF8459',
      --     yellow = '#CAA75E',
      --     green = '#87A35E',
      --   },
      --   frappe = extend_base {
      --     text = '#fcfcfa',
      --     surface2 = '#535763',
      --     surface1 = '#3a3d4b',
      --     surface0 = '#30303b',
      --     base = '#202027',
      --     mantle = '#1c1d22',
      --     crust = '#171719',
      --   },
      -- },
    }
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.opt.background = 'dark'
    -- vim.o.guifont = 'MonaspiceNe Nerd Font Mono:h16'
    vim.o.guifont = 'VictorMono Nerd Font Mono:h16'
    vim.cmd.colorscheme 'catppuccin'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
