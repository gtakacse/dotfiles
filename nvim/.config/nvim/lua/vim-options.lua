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
vim.cmd("set listchars=tab:»\\ ,leadmultispace:»\\ ,trail:-,eol:↲")
vim.cmd("set mouse=")
vim.cmd("set cursorline")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.swapfile = false

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

vim.keymap.set("n", "<C-Left>", "<C-W><", {})
vim.keymap.set("n", "<C-Right>", "<C-W>>", {})
vim.keymap.set("n", "<C-Up>", "<C-W>+", {})
vim.keymap.set("n", "<C-Down>", "<C-W>-", {})

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})
-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
