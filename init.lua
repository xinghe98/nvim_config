--[[

██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗  ██╗███████╗
╚██╗██╔╝██║████╗  ██║██╔════╝     ██║  ██║██╔════╝
 ╚███╔╝ ██║██╔██╗ ██║██║  ███╗    ███████║█████╗
 ██╔██╗ ██║██║╚██╗██║██║   ██║    ██╔══██║██╔══╝
██╔╝ ██╗██║██║ ╚████║╚██████╔╝    ██║  ██║███████╗
╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚══════╝

 ]]

-- 主要配置
require("config.markdown")
require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmd")

-- 加载主题
vim.cmd("colorscheme deus")
-- 覆盖高亮组以实现透明背景
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })


vim.g.coc_global_extensions = {
	"coc-marketplace",
	"coc-word",
	"coc-css",
	"coc-highlight",
	"coc-sumneko-lua",
	"coc-go",
	"coc-diagnostic",
	"coc-docker",
	-- "coc-eslint",
	"coc-flutter",
	"coc-gitignore",
	"coc-git",
	"coc-html",
	"coc-jest",
	"coc-json",
	"coc-lists",
	"coc-omnisharp",
	"coc-prettier",
	"coc-prisma",
	"coc-snippets",
	"https://github.com/rafamadriz/friendly-snippets@main",
	-- "coc-syntax",
	"coc-word",
	"coc-emoji",
	"coc-tsserver",
	"@yaegassy/coc-volar",
	"coc-emmet",
	"coc-yaml",
	"coc-yank",
	"coc-pyright",
	"coc-symbol-line"
}
