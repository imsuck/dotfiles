---vim.opt.guicursor = ""
vim.opt.guifont = "Fira Code:h10, Arimo Nerd Font:h10"

vim.opt.nu = true
vim.opt.relativenumber = true

if vim.g.neovide then
    vim.g.neovide_padding_top = 10
    vim.g.neovide_padding_left = 10
    vim.g.neovide_padding_right = 10
    vim.g.neovide_padding_bottom = 10
    vim.opt.winblend = 90
    vim.opt.pumblend = 90
end

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
-- vim.opt.cmdheight = 0

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "
-- Don't timeout for leader key
vim.cmd("set noto")
vim.cmd("set nottimeout")

