do
	vim.pack.add({
		{
			src = "https://github.com/smithbm2316/centerpad.nvim",
		},
	})

	-- I don't want the centered window to disappear when I want to delete the current buffer
	vim.api.nvim_create_user_command("BufDel", function()
		vim.cmd("enew | bd#")
	end, { desc = "create a new buffer in current window and delete the previous buffer, preserving the window" })
end
