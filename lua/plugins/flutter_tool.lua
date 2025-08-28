local flutter_path

-- 自动检测flutter路径
if vim.fn.has("win32") == 1 then
	-- Windows 系统: 使用 PowerShell 的 Get-Command 查找
	flutter_path =
		vim.fn.trim(vim.fn.system([[powershell -Command "& {Get-Command flutter | Select-Object -ExpandProperty Path}"]]))
else
	-- Unix 系统: 使用 `which` 命令查找
	flutter_path = vim.fn.trim(vim.fn.system("which flutter"))
end
return {
	{
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		opts = {
			-- flutter_path = "/usr/bin/flutter",
			-- flutter_path = "/Users/lixinghe/.local/share/flutter/bin/flutter",
			flutter_path = flutter_path,
			ui = {
				border = "rounded",
			},
			decorations = {
				statusline = {
					-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
					-- this will show the current version of the flutter app from the pubspec.yaml file
					app_version = true,
					-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
					-- this will show the currently running device if an application was started with a specific
					-- device
					device = true,
					-- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
					-- this will show the currently selected project configuration
					project_config = false,
				},
			},
			root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
			fvm = false,                       -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
			widget_guides = {
				enabled = false,
			},
			closing_tags = {
				highlight = "Comment", -- highlight for the closing tag
				prefix = "//", -- character to use for close tag e.g. > Widget
				enabled = false, -- set to false to disable
			},
			dev_log = {
				enabled = false,
				notify_errors = false, -- if there is an error whilst running then notify the user
				open_cmd = "tabnew",
				focus_on_open = false,
			},
			dev_tools = {
				autostart = false, -- autostart devtools server if not detected
				auto_open_browser = false, -- Automatically opens devtools in the browser
			},
			outline = {
				open_cmd = "30vnew", -- command to use to open the outline buffer
				auto_open = false, -- if true this will open the outline automatically when it is first populated
			},
			lsp = {
				color = { -- show the derived colours for dart variables
					enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
					background = false, -- highlight the background
					background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
					foreground = false, -- highlight the foreground
					virtual_text = true, -- show the highlight using virtual text
					virtual_text_str = "■", -- the virtual text character to highlight
				},
				settings = {
					enableSnippets = true,
					showTodos = true,
					completeFunctionCalls = true,
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("$HOME/fvm"),
					},
					lineLength = vim.g.flutter_format_line_length,
				},
			},
		},
		ft = "dart",
	},
}
