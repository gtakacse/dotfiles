vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.listchars = "tab:»\\ ,leadmultispace:»\\ ,trail:-,eol:↲"
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.mouse = ""

-- Generic key bindings
vim.keymap.set("i", "jk", "<esc>", {})

-- Buffer actions
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", {})
vim.keymap.set("n", "<Tab>", ":bnext<CR>", {})
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", {})
-- vim.keymap.set("n", "<leader>o", "i<CR><esc>", {})

-- Tab actions
vim.keymap.set("n", "<C-t>", ":tabnew %<CR>", {})

-- Window actions
vim.keymap.set("n", "w-", ":split<CR>", {})
vim.keymap.set("n", "w\\", ":vsplit<CR>", {})
vim.keymap.set("n", "<C-x>", "<C-W>c", {})

-- Window navigation
vim.keymap.set("n", "<C-j>", "<C-W>j", {})
vim.keymap.set("n", "<C-k>", "<C-W>k", {})
vim.keymap.set("n", "<C-h>", "<C-W>h", {})
vim.keymap.set("n", "<C-l>", "<C-W>l", {})

-- Window resize
vim.keymap.set("n", "<C-Left>", "<C-W><", {})
vim.keymap.set("n", "<C-Right>", "<C-W>>", {})
vim.keymap.set("n", "<C-Up>", "<C-W>+", {})
vim.keymap.set("n", "<C-Down>", "<C-W>-", {})

-- Move highlighted text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Smart paste
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete without trace
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Quickfix navigation
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- Smart replace
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text.",
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
