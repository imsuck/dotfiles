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
    comments = { italic = false },
    keywords = { italic = false },
    sidebars = "transparent",
  },
  on_highlights = function(hl, c)
    hl.LineNr = {
      fg = c.fg_dark,
    }
    hl.CursorLine = {
        bg = c.none,
    }
    hl.CursorLineNr = {
      bold = true,
      fg = c.white,
    }
  end,
})

vim.cmd("colorscheme tokyonight")

