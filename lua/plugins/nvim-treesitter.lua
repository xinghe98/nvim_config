return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter")

		configs.setup({
			ensure_installed = { "vim", "vimdoc", "go", "python", "typescript", "query", "c", "vim", "html", "css", "vue", "lua", "dart", "markdown", "markdown_inline", "tsx", "javascript" },
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
		-- 确保语法高亮开启
		vim.cmd("syntax enable")
	end
}
