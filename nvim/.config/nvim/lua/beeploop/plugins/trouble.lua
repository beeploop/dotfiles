do
	vim.pack.add({
		{
			src = "https://github.com/folke/trouble.nvim",
		},
	})

	require("trouble").setup({})

	vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
end
