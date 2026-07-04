do
	local telescope_plugins = {
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
		"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	}
	if vim.fn.executable("make") == 1 then
		table.insert(telescope_plugins, "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
	end

	vim.pack.add(telescope_plugins)

	-- See `:help telescope` and `:help telescope.setup()`
	require("telescope").setup({
		-- You can put your default mappings / updates / etc. in here
		--  All the info you're looking for is in `:help telescope.setup()`
		--
		-- defaults = {
		--   mappings = {
		--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
		--   },
		-- },
		-- pickers = {}
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	})

	-- Enable Telescope extensions if they are installed
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- See `:help telescope.builtin`
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>dl", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
	vim.keymap.set("n", "<leader>f", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[ ] Find existing buffers" })

	-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
	-- If you later switch picker plugins, this is where to update these mappings.
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
			map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
			map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
			map("K", vim.lsp.buf.hover, "[K] Hover")
		end,
	})

	-- Override default behavior and theme when searching
	vim.keymap.set("n", "<leader>/", function()
		-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	-- It's also possible to pass additional configuration options.
	--  See `:help telescope.builtin.live_grep()` for information about particular keys
	vim.keymap.set("n", "<leader>f/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch [/] in Open Files" })

	-- Shortcut for searching your Neovim configuration files
	vim.keymap.set("n", "<leader>fn", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim files" })
end
