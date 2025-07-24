return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			ignore_install = { "help" },
			ensure_installed = { "vim", "vimdoc", "go", "python", "typescript", "query", "c", "vim", "html", "vue", "lua", "dart" },
			highlight = {
				enable = true,
			},
		}
		-- 确保语法高亮开启
		vim.cmd("syntax enable")
	end
}
