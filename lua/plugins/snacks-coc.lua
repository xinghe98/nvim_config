return {
	{
		-- dir = "/Users/xinghe/Documents/snacks-coc.nvim", -- 本地开发目录
		"xinghe98/snacks-coc.nvim",
		dependencies = { "folke/snacks.nvim", "neoclide/coc.nvim" },
		event = "VeryLazy",
		opts = { prefer_locations = false },
		config = function(_, opts)
			require("snacks-coc").setup(opts)
		end,
		-- 下面是你原来的快捷键替换后的懒加载写法：
		keys = {
			-- 诊断
			{ "<leader>gg", function() Snacks.picker.pick("coc_diagnostics") end, desc = "诊断", silent = true },
			{ "<leader>gG", function() Snacks.picker.pick("coc_workspace_diagnostics") end, desc = "工作区诊断", silent = true },

			-- GoTo code navigation
			{ "gd", function() Snacks.picker.pick("coc_definitions") end, desc = "跳转到定义", silent = true },
			{ "gy", function() Snacks.picker.pick("coc_type_definitions") end, desc = "跳转到类型定义", silent = true },
			{ "gi", function() Snacks.picker.pick("coc_implementations") end, desc = "跳转到实现", silent = true },
			{ "gr", function() Snacks.picker.pick("coc_references_used") end, desc = "跳转到引用", silent = true },
		},
	}
}
