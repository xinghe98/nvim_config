--[[

██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗  ██╗███████╗
╚██╗██╔╝██║████╗  ██║██╔════╝     ██║  ██║██╔════╝
 ╚███╔╝ ██║██╔██╗ ██║██║  ███╗    ███████║█████╗
 ██╔██╗ ██║██║╚██╗██║██║   ██║    ██╔══██║██╔══╝
██╔╝ ██╗██║██║ ╚████║╚██████╔╝    ██║  ██║███████╗
╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚══════╝

 ]]


if not vim.g.vscode then
	require("config.lazy")
	require("config.autocmd")
	-- vim.cmd([[colorscheme gruvbox-material]])
	vim.cmd([[colorscheme everforest]])
	require("config.options")
end
-- 主要配置
require("config.markdown")
require("config.keymaps")


vim.g.coc_global_extensions = {
	"coc-marketplace",
	"coc-word",
	"coc-css",
	"coc-highlight",
	"coc-sumneko-lua",
	-- "coc-go",
	"coc-diagnostic",
	"coc-docker",
	-- "coc-eslint",
	--	"coc-flutter",
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
