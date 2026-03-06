return {
	chat = {
		adapter = "yunwu",
		opts = {
			completion_provider = "coc",
		},

		tools = {
			["mcp"] = {
				opts = {
					servers = {
						["filesystem"] = {
							cmd = "npx",
							args = { "-y", "@modelcontextprotocol/server-filesystem", vim.fn.getcwd() },
						},
					},
				},
			},
			opts = {
				default_tools = {
					"run_command",
					"insert_edit_into_file",
					"read_file",
					"create_file",
					"web_search",
					"fetch_webpage",
				},
			},
		},
	},
	inline = {
		adapter = "deepseek",
		opts = {
			completion_provider = "coc",
		},
	},
}
