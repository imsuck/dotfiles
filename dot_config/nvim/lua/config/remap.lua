local nnoremap = require("config.keymap").nnoremap
local inoremap = require("config.keymap").inoremap

local tele_builtin = require("telescope.builtin")

nnoremap("<Esc>", "<cmd>:q<CR>")
nnoremap("<leader><Esc>", "")
nnoremap("<leader>f", tele_builtin.find_files)
nnoremap("<leader>F", "<cmd>Ex<CR>")
nnoremap("<leader>b", tele_builtin.buffers)
nnoremap("<C-s>", "<cmd>:w<CR>")
nnoremap("ge", "<cmd>:$<CR>")
nnoremap("gs", "_")
nnoremap("gh", "^")
nnoremap("gl", "$")
nnoremap("<leader>w", "<C-w>")

inoremap("<C-S>", "<cmd>:w<CR>")

