vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>ev', '<Cmd>e $MYVIMRC<CR>', { desc = '[E]dit $MY[V]IMRC' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- -- Terminal specific overrides
-- vim.api.nvim_create_autocmd('TermOpen', {
--   pattern = '*',
--   callback = function()
--     vim.opt.number = false
--   end,
-- })

if vim.g.neovide then
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
  vim.keymap.set('i', '<C-e>', '<C-o><C-e>')
  vim.keymap.set('i', '<C-y>', '<C-o><C-y>')
  vim.keymap.set('t', '<C-e>', [[<C-\><C-n><C-y>i]])
  vim.keymap.set('t', '<C-y>', [[<C-\><C-n><C-e>i]])
  vim.keymap.set('n', '<D-a>', '<ESC>ggvG$')
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('n', '<D-f>', '/')
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  -- normal mode
  vim.keymap.set('n', '<D-Left>', '0', { noremap = true, desc = 'Move to start of line' })
  vim.keymap.set('n', '<D-Right>', '$', { noremap = true, desc = 'Move to end of line' })
  vim.keymap.set('n', '<A-left>', 'b', { noremap = true, desc = 'Move to start of word' })
  vim.keymap.set('n', '<A-right>', 'w', { noremap = true, desc = 'Move to end of word' })
  vim.keymap.set('n', '<D-BS>', 'd0', { noremap = true, desc = 'Delete to start of line' })
  vim.keymap.set('n', '<A-BS>', 'db', { noremap = true, desc = 'Delete previous word' })
  vim.keymap.set('n', '<D-Del>', 'd$', { noremap = true, desc = 'Delete to end of line' })
  vim.keymap.set('n', '<A-Del>', 'dw', { noremap = true, desc = 'Delete to end of word' })
  vim.keymap.set('n', '<C-Left>', '<C-w>h', { noremap = true, desc = 'Select window to the left' })
  vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, desc = 'Select window to the right' })
  vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, desc = 'Select window above' })
  vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, desc = 'Select window below' })
  -- visual mode
  vim.keymap.set('v', '<D-Left>', '0', { noremap = true, desc = 'Move to start of line' })
  vim.keymap.set('v', '<D-Right>', '$', { noremap = true, desc = 'Move to end of line' })
  vim.keymap.set('v', '<A-left>', 'b', { noremap = true, desc = 'Move to start of word' })
  vim.keymap.set('v', '<A-right>', 'w', { noremap = true, desc = 'Move to end of word' })
  -- insert mode
  vim.keymap.set('i', '<D-Left>', '<C-o>0', { noremap = true, desc = 'Move to start of line' })
  vim.keymap.set('i', '<D-Right>', '<C-o>$', { noremap = true, desc = 'Move to end of line' })
  vim.keymap.set('i', '<A-Left>', '<C-o>b', { noremap = true, desc = 'Move to start of word' })
  vim.keymap.set('i', '<A-Right>', '<C-o>w', { noremap = true, desc = 'Move to end of word' })
  vim.keymap.set('i', '<D-BS>', '<C-u>', { noremap = true, desc = 'Delete to start of line' })
  vim.keymap.set('i', '<A-BS>', '<C-w>', { noremap = true, desc = 'Delete previous word' })
  vim.keymap.set('i', '<D-Del>', '<C-o>D', { noremap = true, desc = 'Delete to end of line' })
  vim.keymap.set('i', '<A-Del>', '<C-o>dw', { noremap = true, desc = 'Delete to end of word' })
else
  -- normal
  vim.keymap.set('n', '<M-C-S-A>', '0', { noremap = true, desc = 'Move to start of line' })
  vim.keymap.set('n', '<M-S-CR>', '$', { noremap = true, desc = 'Move to end of line' })
  vim.keymap.set('n', '<M-b>', 'b', { noremap = true, desc = 'Move to start of word' })
  vim.keymap.set('n', '<M-f>', 'w', { noremap = true, desc = 'Move to end of word' })
  vim.keymap.set('n', '<M-O>', 'd0', { noremap = true, desc = 'Delete to start of line' })
  vim.keymap.set('n', '<M-BS>', 'db', { noremap = true, desc = 'Delete previous word' })
  vim.keymap.set('n', '<M-C-S-P>', 'd$', { noremap = true, desc = 'Delete to end of line' })
  vim.keymap.set('n', '<M-d>', 'dw', { noremap = true, desc = 'Delete to end of word' })
  -- insert
  vim.keymap.set('i', '<M-C-S-A>', '<C-o>0', { noremap = true, desc = 'Move to start of line' })
  vim.keymap.set('i', '<M-S-CR>', '<C-o>$', { noremap = true, desc = 'Move to end of line' })
  vim.keymap.set('i', '<M-b>', '<C-o>b', { noremap = true, desc = 'Move to start of word' })
  vim.keymap.set('i', '<M-f>', '<C-o>w', { noremap = true, desc = 'Move to end of word' })
  vim.keymap.set('i', '<M-O>', '<C-u>', { noremap = true, desc = 'Delete to start of line' })
  vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true, desc = 'Delete previous word' })
  vim.keymap.set('i', '<M-C-S-P>', '<C-o>D', { noremap = true, desc = 'Delete to end of line' })
  vim.keymap.set('i', '<M-d>', '<C-o>dw', { noremap = true, desc = 'Delete to end of word' })
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
