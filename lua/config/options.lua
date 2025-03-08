local set = vim.opt
set.modifiable = true
set.number = true
set.rnu = true
set.cursorline = true
set.cursorcolumn = true
-- 可以拆行
set.wrap = true
vim.opt.fileformat = "unix"
set.cindent = true
set.tabstop = 4
set.shiftwidth = 4
set.showmatch = true
set.scrolloff = 5
set.laststatus = 2
set.fenc = "utf-8"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
set.matchtime = 5
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true
set.expandtab = false
set.autoread = true
vim.g.t_Co = 256
vim.opt.termguicolors = true
vim.opt.completeopt = { "preview", "noselect", "noinsert" }
-- vim.opt.completeopt = { "noinsert", "menuone", "noselect", "preview" }
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.timeoutlen = 500
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.pumheight = 10
vim.o.splitright = true
vim.opt.signcolumn = "yes"
vim.o.foldmethod = "indent"
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 100

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"
vim.notify = require("notify")
vim.g.translator_default_engines = { "haici", "google" }
vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
	virtual_text = {
		prefix = "😥",
	},
})
