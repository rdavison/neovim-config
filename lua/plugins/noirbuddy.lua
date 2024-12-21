-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

local function hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  return tonumber('0x' .. hex:sub(1, 2)), tonumber('0x' .. hex:sub(3, 4)), tonumber('0x' .. hex:sub(5, 6))
end

local function rgb_to_hex(r, g, b)
  return string.format('#%02X%02X%02X', r, g, b)
end

local function linear_gradient(color1, color2, steps)
  local r1, g1, b1 = hex_to_rgb(color1)
  local r2, g2, b2 = hex_to_rgb(color2)
  local gradient = {}

  for i = 0, steps - 1 do
    local r = r1 + ((r2 - r1) * i / (steps - 1))
    local g = g1 + ((g2 - g1) * i / (steps - 1))
    local b = b1 + ((b2 - b1) * i / (steps - 1))
    table.insert(gradient, rgb_to_hex(math.floor(r), math.floor(g), math.floor(b)))
  end

  return gradient
end

local noir_gradient = function(c1, c2)
  local cs = linear_gradient(c1, c2, 10)
  return {
    noir_0 = cs[0],
    noir_1 = cs[1],
    noir_2 = cs[2],
    noir_3 = cs[3],
    noir_4 = cs[4],
    noir_5 = cs[5],
    noir_6 = cs[6],
    noir_7 = cs[7],
    noir_8 = cs[8],
    noir_9 = cs[9],
  }
end

local table_update = function(table, update)
  for k, v in pairs(update) do
    table[k] = v
  end
end

local four_tone = function(primary, secondary, grad_start, grad_end)
  local colors = noir_gradient(grad_start, grad_end)
  table_update(colors, { primary = primary, secondary = secondary })
  return { colors = colors }
end

local presets = function(name)
  local opts = {
    styles = {
      italic = true,
      bold = true,
      underline = true,
      undercurl = false,
    },
  }
  local lookup = {
    ['christmas'] = { preset = 'christmas' },
    ['crt-amber'] = { preset = 'crt-amber' },
    ['crt-green'] = { preset = 'crt-green' },
    ['kiwi'] = { preset = 'kiwi' },
    ['miami-nights'] = { preset = 'miami-nights' },
    ['minimal'] = { preset = 'minimal' },
    ['northern-lights'] = { preset = 'northern-lights' },
    ['oxide'] = { preset = 'oxide' },
    ['slate'] = { preset = 'slate' },
    -- ['stronglytyped2'] = {
    --   colors = {
    --     background = '#bbbcbc',
    --     diagnostic_error = '#ff0088',
    --     diagnostic_hint = '#ced5f1',
    --     diagnostic_info = '#00ff88',
    --     diagnostic_warning = '#ffccdd',
    --     diff_add = '#00ff88',
    --     diff_change = '#ced5f1',
    --     diff_delete = '#ff0088',
    --     gray0 = '#7b7c7c',
    --     gray1 = '#888989',
    --     gray2 = '#949595',
    --     gray3 = '#d2d3d3',
    --     gray4 = '#dadada',
    --     gray5 = '#e1e1e1',
    --     gray6 = '#e7e7e7',
    --     gray7 = '#ededed',
    --     gray8 = '#f3f4f4',
    --     gray9 = '#f9f9f9',
    --     noir_0 = '#f9f9f9',
    --     noir_1 = '#f3f4f4',
    --     noir_2 = '#ededed',
    --     noir_3 = '#e1e1e1',
    --     noir_4 = '#dadada',
    --     noir_5 = '#d2d3d3',
    --     noir_6 = '#9fa0a0',
    --     noir_7 = '#949595',
    --     noir_8 = '#888989',
    --     noir_9 = '#7b7c7c',
    --     primary = '#ff8d6d',
    --     secondary = '#859587',
    --   },
    -- },
    ['stronglytyped3'] = {
      colors = {
        diagnostic_error = '#f6cbdd',
        diagnostic_hint = '#ced5f1',
        diagnostic_info = '#ffe57c',
        diagnostic_warning = '#ffffe5',
        diff_add = '#d4efd1',
        diff_change = '#ced5f1',
        diff_delete = '#f6cbdd',
        -- gray0 = '#5f6a63',
        -- gray1 = '#987e7c',
        -- gray2 = '#b08f8d',
        gray0 = '#ff6a63',
        gray1 = '#98fe7c',
        gray2 = '#b08ffd',
        gray3 = '#ffffff',
        gray4 = '#ffffff',
        gray5 = '#ffffff',
        gray6 = '#ffffff',
        gray7 = '#ffffff',
        gray8 = '#ffffff',
        gray9 = '#ffffff',
        noir_0 = '#ffffff',
        noir_1 = '#ffffff',
        noir_2 = '#ffffff',
        noir_3 = '#f7e8fc',
        noir_4 = '#e2d7ea',
        noir_5 = '#d1c6d6',
        noir_6 = '#beb0c2',
        noir_7 = '#6d6981',
        noir_8 = '#a994be',
        noir_9 = '#9f93b6',
        background = '#80768f',
        primary = '#ffe5ff',
        secondary = '#ced5f1',
      },
    },
    -- ['stronglytyped'] = {
    --   colors = {
    --     diagnostic_error = '#ff0088',
    --     diagnostic_hint = '#ced5f1',
    --     diagnostic_info = '#00ff88',
    --     diagnostic_warning = '#ffccdd',
    --     diff_add = '#00ff88',
    --     diff_change = '#ced5f1',
    --     diff_delete = '#ff0088',
    --     gray0 = '#5f6a63',
    --     gray1 = '#987e7c',
    --     gray2 = '#b08f8d',
    --     gray3 = '#ffffff',
    --     gray4 = '#ffffff',
    --     gray5 = '#ffffff',
    --     gray6 = '#ffffff',
    --     gray7 = '#ffffff',
    --     gray8 = '#ffffff',
    --     gray9 = '#ffffff',
    --     noir_0 = '#ffffff',
    --     noir_1 = '#ffffff',
    --     noir_2 = '#ffffff',
    --     noir_3 = '#f7e8fc',
    --     noir_4 = '#e2d7ea',
    --     noir_5 = '#d1c6d6',
    --     noir_6 = '#beb0c2',
    --     noir_7 = '#ab98a8',
    --     noir_8 = '#978a99',
    --     noir_9 = '#888594',
    --     background = '#7e7987',
    --     primary = '#ffe5ff',
    --     secondary = '#ced5f1',
    --   },
    -- },
  }
  local found = lookup[name]
  if found then
    table_update(opts, found)
  end
  return opts
end

return {
  'jesseleite/nvim-noirbuddy',
  dependencies = {
    { 'tjdevries/colorbuddy.nvim' },
  },
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require('noirbuddy').setup(opts)
    local colorbuddy = require 'colorbuddy'
    -- Require colorbuddy...
    -- colorbuddy.colorscheme 'noirbuddy'
    local C = colorbuddy.Color
    local c = colorbuddy.colors
    local G = colorbuddy.Group
    local g = colorbuddy.groups
    local s = colorbuddy.styles

    G.new('Normal', nil, nil, nil)
    G.new('@keyword', c.primary, nil, s.italic)
    G.new('@keyword.function', c['primary'], nil, g['@keyword'])
    G.new('@keyword.return', c['@keyword'], nil, g['@keyword'])
    G.new('@keyword.operator', c.primary, nil, g['@keyword'])
    G.new('@variable', c.noir_1, nil, nil)
    G.new('@variable.parameter.python', c.noir_1, nil, s.bold)
    -- G.new('@variable.builtin.python', c.secondary, nil, s.bold)
    -- G.new('@attribute.builtin.python', c.primary, nil, nil)
    G.new('@type', c.noir_4, nil, nil)
    G.new('@type.builtin.python', c.noir_4, nil, nil)
    G.new('@attribute', c.secondary, nil, nil)
    G.new('@string.documentation.python', c.primary, nil, s.italic)
    G.new('@comment', c.noir_5, nil, s.bold + s.italic)
    G.new('@comment.warning', c.black, c.diagnostic_warning, s.bold + s.italic)
    G.new('@comment.todo', c.black, c.diff_add, s.bold + s.italic)
    G.new('@comment.note', c.black, c.diagnostic_hint, s.bold + s.italic)
    G.new('@comment.error', c.white, c.diagnostic_error, s.bold + s.italic)
    G.new('Comment', c.noir_5, nil, s.italic)
    G.new('@function.python', c.noir_1, nil, s.bold)
    G.new('@python.custom.class_name', c.noir_1, nil, s.bold)
    G.new('@punctuation.bracket', c.noir_4, nil, nil)
    G.new('@punctuation.delimiter', c.noir_4, nil, nil)
    G.new('@operator', c.noir_4, nil, nil)
    G.new('@boolean', c.secondary, nil, nil)
    G.new('@number', c.secondary, nil, nil)
    G.new('@function.method.call.python', c.noir_2, nil, nil)
    G.new('LineNr', c.noir_3, nil, nil)
    G.new('Cursor', nil, c.primary, nil, nil)
    G.new('CursorLine', c.primary, c.noir_8, nil)
    G.new('MiniFilesBorder', c.white, c.noir_8, nil)
    G.new('MiniFilesBorderModified', c.white, c.noir_9, nil)
    -- G.new('MiniFilesFile', c.white, nil, nil)
    G.new('MiniFilesNormal', c.white, c.noir_8, nil)
    G.new('MiniFilesTitle', c.white, c.noir_8, nil)
    G.new('MiniFilesTitleFocused', c.white, c.noir_8, nil)
    -- G.new('MiniFilesCursorLine', c.white, c.noir_7, nil)
    G.new('FidgetWindow', c['Comment'], c.background, nil)
    G.new('FidgetBorder', c.primary, c['FidgetWindow'], nil)
    G.new('WhichKeyNormal', c.primary, c.noir_8, nil)
    G.new('NormalFloat', nil, c.noir_8, nil)
    G.new('FloatBorder', c.primary, c.noir_8, nil)
    G.new('TelescopePreviewNormal', nil, c.noir_8, nil)
    G.new('TelescopePromptNormal', nil, c.noir_8, nil)
    G.new('TelescopeResultsNormal', nil, c.noir_8, nil)
    G.new('TelescopeSelection', c.primary, nil, nil)
  end,
  opts = presets 'stronglytyped3',
}
