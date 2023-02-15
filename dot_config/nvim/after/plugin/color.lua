local is_transparent;
if not vim.g.neovide then
  is_transparent = true
else
  is_transparent = false
end

require("tokyonight").setup({
  style = "storm",
  transparent = is_transparent,
  styles = {
    sidebars = "transparent",
  },
  on_highlights = function(hl, c)
    hl.LineNr = {
      fg = c.grey,
    }
    hl.CursorLineNr = {
      bold = true,
      fg = c.fg,
    }
  end,
})

vim.cmd("colorscheme tokyonight")

