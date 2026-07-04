do
	vim.pack.add({
		{
			src = "https://github.com/tiagovla/tokyodark.nvim",
		},
	})

	require("tokyodark").setup()

	vim.cmd.colorscheme("tokyodark")
end
