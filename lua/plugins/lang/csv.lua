return {
  'cameron-wags/rainbow_csv.nvim',
  config = function()
    require('rainbow_csv').setup()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'tsv',
      callback = function()
        vim.opt_local.cursorline = true
        vim.opt_local.colorcolumn = ''
        require('rainbow_csv.fns').csv_align()
      end,
    })
  end,
  ft = {
    'csv',
    'tsv',
    'csv_semicolon',
    'csv_whitespace',
    'csv_pipe',
    'rfc_csv',
    'rfc_semicolon',
  },
  cmd = {
    'RainbowDelim',
    'RainbowDelimSimple',
    'RainbowDelimQuoted',
    'RainbowMultiDelim',
  },
}
