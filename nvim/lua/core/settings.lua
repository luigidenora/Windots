local opt = vim.opt

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.updatetime = 50

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.swapfile = false
opt.backup = false
-- opt.undodir = os.getenv("HOME") .. ".vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

vim.cmd.colorscheme "catppuccin"

vim.diagnostic.config({
  virtual_text = true,
  signs = {
     text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})
-- undofile 
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
