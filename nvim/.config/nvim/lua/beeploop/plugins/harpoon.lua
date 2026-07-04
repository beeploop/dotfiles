do
	vim.pack.add({
		{
			src = "https://github.com/nvim-lua/plenary.nvim",
		},
		{
			src = "https://github.com/ThePrimeagen/harpoon",
			version = "harpoon2",
		},
	})

	local harpoon = require("harpoon")
	harpoon:setup()

	local keymap = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { desc = "Harpoon: " .. desc })
	end

	-- List files
	keymap("<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, "Open harpoon window")

	-- Add harpoon file
	keymap("<leader>a", function()
		harpoon:list():add()
	end, "Add harpoon file")

	-- Jumping around
	keymap("<C-i>", function()
		harpoon:list():select(1)
	end, "Jump to harpoon file 1")

	keymap("<C-o>", function()
		harpoon:list():select(2)
	end, "Jump to harpoon file 2")

	keymap("<C-p>", function()
		harpoon:list():select(3)
	end, "Jump to harpoon file 3")

	keymap("<C-l>", function()
		harpoon:list():select(4)
	end, "Jump to harpoon file 4")
end
