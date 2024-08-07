vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber number")
vim.cmd("set timeoutlen=1000")
vim.cmd("set ttimeoutlen=0")
vim.cmd("set backspace=eol,start,indent")
vim.cmd("set whichwrap+=<,>,h,l")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set magic")

vim.g.mapleader = " "
-- Generic key bindings
vim.keymap.set("i", "jk", "<esc>", {})
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", {})
vim.keymap.set("n", "<Tab>", ":bnext<CR>", {})
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", {})
-- vim.keymap.set("n", "<leader>o", "i<CR><esc>", {})

vim.keymap.set("n", "<C-j>", "<C-W>j", {})
vim.keymap.set("n", "<C-k>", "<C-W>k", {})
vim.keymap.set("n", "<C-h>", "<C-W>h", {})
vim.keymap.set("n", "<C-l>", "<C-W>l", {})
