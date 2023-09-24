local c = require("tokyonight.colors").setup({ style = "storm" })

require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
      },
    },
  },
  highlights = {
    buffer_selected = {
      italic = false,
    },
  },
}
