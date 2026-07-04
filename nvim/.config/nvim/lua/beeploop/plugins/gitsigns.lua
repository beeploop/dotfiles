do
	vim.pack.add({
		{
			src = "https://github.com/lewis6991/gitsigns.nvim",
		},
	})

	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "m" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- toggle with `:gitsigns toggle_signs`
		numhl = false, -- toggle with `:gitsigns toggle_numhl`
		linehl = false, -- toggle with `:gitsigns toggle_linehl`
		word_diff = false, -- toggle with `:gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- use default
		max_file_length = 40000, -- disable if file is longer than this (in lines)
		preview_config = {
			-- options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
end
