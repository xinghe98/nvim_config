return {
	'chentoast/marks.nvim',
	event = 'VeryLazy',
	opts = {
		{
			default_mappings = false,
			mappings = {
				set = "'",
				delete = "d'",
				delete_buf = "d'b",
				set_next = "',",
				next = "']",
				preview = "':",
				set_bookmark0 = "'0",
				prev = false -- pass false to disable only this default mapping
			}
		}

	}
}
