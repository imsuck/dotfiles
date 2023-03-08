local tele_builtin = require("telescope.builtin")

vim.keymap.set("n", "<Esc>", "<cmd>:q<CR>")
vim.keymap.set("n", "<leader><Esc>", "")
vim.keymap.set("n", "<leader>f", "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>F", tele_builtin.find_files)
vim.keymap.set("n", "<leader>b", tele_builtin.buffers)
vim.keymap.set("n", "<C-s>", "<cmd>:w<CR>")
vim.keymap.set("n", "ge", "<cmd>:$<CR>")
vim.keymap.set("n", "gs", "_")
vim.keymap.set("n", "gh", "^")
vim.keymap.set("n", "gl", "$")
vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("i", "<C-S>", "<cmd>:w<CR>")

