do
	vim.pack.add({
		{
			src = "https://github.com/folke/zen-mode.nvim",
		},
	})

	require("zen-mode").setup({
		window = {
			width = 90,
			options = {
				number = false,
				relativenumber = false,
				cursorline = false,
				cursorcolumn = false,
			},
		},
		plugins = {
			options = {
				enabled = true,
				shocmd = true,
				laststatus = 3,
			},
			tmux = { enabled = false },
		},
	})

	vim.keymap.set("n", "<leader>zz", require("zen-mode").toggle, { desc = "Toggle Zen Mode" })
end
