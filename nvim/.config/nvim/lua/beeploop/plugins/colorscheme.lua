do
	vim.pack.add({
		{
			src = "https://github.com/tiagovla/tokyodark.nvim",
		},
	})

	require("tokyodark").setup()

	vim.cmd.colorscheme("tokyodark")

	local transparent = function()
		local groups = {
			"Normal",
			"NormalFloat",
			"SignColumn",
			"EndOfBuffer",
		}

		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end

	transparent()
end
