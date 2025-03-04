return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	config = function()
		require("packsettings.markdownpre")
	end,
	dependencies = {

		{ "dhruvasagar/vim-table-mode" },
		{ "mzlogin/vim-markdown-toc" },
		{ "godlygeek/tabular" },
		{
			"dkarter/bullets.vim",
		},
	},
}
