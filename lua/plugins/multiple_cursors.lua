return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*",
	event = "VimEnter", -- 启动时立即加载
	opts = {},
	config = function()
		require("multiple-cursors").setup({})

		-- 手动设置快捷键
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap({ "n", "x" }, "<C-e>", "<Cmd>MultipleCursorsAddDown<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursor and move down" }))
		keymap({ "n", "x" }, "<C-u>", "<Cmd>MultipleCursorsAddUp<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursor and move up" }))

		keymap({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursor and move up" }))
		keymap({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursor and move down" }))

		keymap({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",
			vim.tbl_extend("force", opts, { desc = "Add or remove cursor" }))

		keymap({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursors to cword" }))
		keymap({ "n", "x" }, "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursors to cword in previous area" }))
		keymap({ "n", "x" }, "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
			vim.tbl_extend("force", opts, { desc = "Add cursor and jump to next cword" }))
		keymap({ "n", "x" }, "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>",
			vim.tbl_extend("force", opts, { desc = "Jump to next cword" }))
		keymap({ "n", "x" }, "<Leader>l", "<Cmd>MultipleCursorsLock<CR>",
			vim.tbl_extend("force", opts, { desc = " virtual cursors" }))
	end,
}
