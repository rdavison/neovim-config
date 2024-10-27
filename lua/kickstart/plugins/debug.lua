-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.set_log_level 'TRACE'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'python',
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F8>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F7>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F6>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F5>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F9>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    local pythonPath = function()
      local cwd = vim.loop.cwd()
      local venv_path = cwd .. '/.venv/bin/python'
      if vim.fn.executable(venv_path) == 1 then
        return venv_path
      else
        return '/usr/bin/python'
      end
    end

    local set_python_dap = function()
      require('dap-python').setup() -- earlier so setup the various defaults ready to be replaced
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = pythonPath(),
        },
        {
          type = 'python',
          request = 'launch',
          name = 'DAP Django',
          program = vim.loop.cwd() .. '/manage.py',
          args = { 'runserver', '--noreload' },
          justMyCode = false,
          django = true,
          console = 'integratedTerminal',
        },
        {
          type = 'python',
          request = 'attach',
          name = 'Attach remote',
          connect = function()
            return {
              host = '127.0.0.1',
              port = 5678,
            }
          end,
          pathMappings = {
            {
              localRoot = '${workspaceFolder}',
              remoteRoot = '/app',
            },
          },
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' +')
          end,
          console = 'integratedTerminal',
          pythonPath = pythonPath(),
        },
      }

      dap.adapters.python = {
        type = 'executable',
        command = pythonPath(),
        args = { '-m', 'debugpy.adapter' },
      }
    end

    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }

    set_python_dap()

    vim.api.nvim_create_autocmd({ 'DirChanged' }, {
      callback = function()
        set_python_dap()
      end,
    })

    -- local function detect_python()
    --   -- Install python specific config
    --   local cwd = vim.fn.getcwd()
    --   local venv_path = cwd .. '/.venv'
    --
    --   local stat = vim.loop.fs_stat(venv_path)
    --   local venv_exists = not not stat
    --
    --   local python_path = 'stinkybutt-' .. cwd
    --   if venv_exists then
    --     python_path = '.venv/bin/python'
    --   end
    --   return python_path
    -- end
    --
    -- require('dap-python').setup(detect_python())
  end,
}
