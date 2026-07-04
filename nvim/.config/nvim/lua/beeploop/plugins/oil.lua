do
	vim.pack.add({
		{
			src = "https://github.com/stevearc/oil.nvim",
		},
	})

	require("oil").setup({})

	vim.keymap.set("n", "<leader>ee", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end
