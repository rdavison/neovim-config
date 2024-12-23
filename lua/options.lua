vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.showmode = false -- mode is already in status line
vim.opt.clipboard = 'unnamedplus' -- share clipboard
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.virtualedit = 'all'
vim.opt.colorcolumn = '90'
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 0
vim.opt.hlsearch = true
vim.opt.jumpoptions:append 'stack'
