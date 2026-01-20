local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opt = { noremap = true }
-- vim.o.langmap = "uk,lu,il,ki,ej,je"
keymap("", ";", ":", opt)
keymap("", "Y", "\"+y", opt)

-- Movement
keymap("", "n", "h", opt)
keymap("", "e", "j", opt)
keymap("", "u", "k", opt)
keymap("", "i", "l", opt)
keymap("", "h", "e", opt)
keymap("", "m", "n", opt)
keymap("", "M", "N", opt)
keymap("n", "'", "m", opt)


keymap("", "U", "5k", opts)
keymap("", "E", "5j", opts)
keymap("", "N", "0", opts)
keymap("", "I", "$", opts)
keymap("", "gu", "gk", opts)
keymap("", "ge", "gj", opts)
keymap("", "<C-U>", "5<C-y>", opts)
keymap("", "<C-E>", "5<C-e>", opts)
keymap("", "ci", "cl", opts)
keymap("", "cn", "ch", opts)
keymap("", "ck", "ci", opts)
keymap("", "c,.", "c%", opts)
keymap("", "yh", "ye", opts)

-- Actions
keymap("", "l", "u", opts)
keymap("", "k", "i", opts)
keymap("", "K", "I", opts)
keymap("", "W", "b", opts)
keymap("n", "<C-k>", "<C-i>", opts)

keymap("n", "<leader>i", "<C-w>l", vim.tbl_extend("force", opts, { desc = "窗口: 向右切换" }))
keymap("n", "<leader>u", "<C-w>k", vim.tbl_extend("force", opts, { desc = "窗口: 向上切换" }))
keymap("n", "<leader>n", "<C-w>h", vim.tbl_extend("force", opts, { desc = "窗口: 向左切换" }))
keymap("n", "<leader>e", "<C-w>j", vim.tbl_extend("force", opts, { desc = "窗口: 向下切换" }))
keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("v", "<Tab>", ">", opts)
keymap("n", "qq", ":nohlsearch<CR>", vim.tbl_extend("force", opts, { desc = "取消高亮" }))
keymap("n", "<S-s>", ":w<CR>", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<S-q>", ":q<CR>", opts)
--[[ keymap('n','<leader><leader>p', ':set paste<CR>',opts)
	keymap('n', '<leader>np', ':set nopaste<CR>',opts) ]]
keymap("n", "r", ":call CompileRunGcc()<CR>", opts)
keymap("n", "<leader>t", ":TranslateW<CR>", vim.tbl_extend("force", opts, { desc = "翻译" }))
keymap("v", "<leader>t", ":TranslateW<CR>", vim.tbl_extend("force", opts, { desc = "翻译" }))
keymap("n", "<C-t>", ":FloatermToggle<CR>", opts)
keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", opts)
-- tab标签页跳转
keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页1" }))
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页2" }))
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页3" }))
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页4" }))
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页5" }))
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", vim.tbl_extend("force", opts, { desc = "跳转到标签页6" }))
keymap("n", "<leader><leader>", ":bn<CR>", vim.tbl_extend("force", opts, { desc = "下一个标签页" }))
keymap("n", "<leader><backspace>", ":bp<CR>", vim.tbl_extend("force", opts, { desc = "上一个标签页" }))
keymap("n", "<c-w>", ":bd<CR>", vim.tbl_extend("force", opts, { desc = "关闭当前标签页" }))
-- nvim-tree
keymap("n", "tt", ":NvimTreeFindFileToggle<CR>", vim.tbl_extend("force", opts, { desc = "打开 nvim-tree" }))
--lazygit
keymap("n", "<leader>lg", "<cmd>LazyGit<cr>", vim.tbl_extend("force", opts, { desc = "打开lazygit" }))
-- copilot
-- keymap("i", "<C-q>", 'copilot#Accept("<CR>")', { script = true, silent = true, expr = true })
--

--- CodeCompanion
-- 切换 AI 对话窗口
keymap("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", opts)
-- 针对选中文本输入 AI 指令
keymap("v", "<leader>aa", ":CodeCompanion ", { noremap = true, silent = false })
-- 打开 AI 操作面板
keymap("n", "<leader>ac", "<cmd>CodeCompanionActions<cr>", opts)
-- 生成中文 Git 提交信息
vim.keymap.set("n", "<leader>am", function()
	vim.cmd("CodeCompanion Commit Message (CN)")
end, { buffer = true, desc = "AI 生成中文 Commit Message" })
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "下一个todo" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "上一个todo" })


keymap("n", "<C-/>", "gcc", { desc = "Toggle comment for line" })
keymap("v", "<C-/>", "gc", { desc = "Toggle comment for selection" })
keymap("n", "<C-_>", "gcc", { desc = "Toggle comment for line" })
keymap("v", "<C-_>", "gc", { desc = "Toggle comment for line" })
vim.cmd([[func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		:FloatermNew --autoclose=0 python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
		exec "TableModeEnable"
	elseif &filetype == 'javascript'
		:FloatermNew --autoclose=0 export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		:FloatermNew --autoclose=0 go run .
	elseif &filetype == 'typescript'
		:FloatermNew --autoclose=0 export DEBUG="INFO,ERROR,WARNING"; ts-node %
	endif
endfunc]])
-- 格式化选中代码 (更新快捷键避免冲突)
keymap("x", "<leader>rf", "<Plug>(coc-format-selected)", { silent = true, desc = "格式化选中代码" })
keymap("n", "<leader>rf", "<Plug>(coc-format-selected)", { silent = true, desc = "格式化选中代码" })
