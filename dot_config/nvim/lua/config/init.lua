local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
  },
  "nvim-lualine/lualine.nvim",
  "lukas-reineke/indent-blankline.nvim",
})

require("config.set")
require("config.remap")
