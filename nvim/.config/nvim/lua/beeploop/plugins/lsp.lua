do
	vim.pack.add({
		{
			src = "https://github.com/mason-org/mason.nvim",
		},
		{
			src = "https://github.com/neovim/nvim-lspconfig",
		},
	})

	require("mason").setup()

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	local servers = {
		lua_ls = {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false

				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						}),
					},
				})
			end,
			settings = {
				Lua = {
					format = { enable = false },
				},
			},
		},

		ts_ls = {
			workspace_required = false,
			filetypes = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			},
			single_file_support = true,
		},

		tailwindcss = {
			filetypes = {
				"html",
				"css",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"astro",
				"svelte",
				"react",
				"templ",
			},
			init_options = {
				userLanguages = {
					astro = "html",
					templ = "html",
				},
			},
			settings = {
				tailwindcss = {
					includeLanguages = {
						templ = "html",
					},
				},
			},
		},

		gopls = {},

		pyright = {
			settings = {
				python = {
					pythonPath = vim.fn.getcwd() .. "./.venv/bin/python",
				},
				pyright = {
					root_dir = require("lspconfig").util.root_pattern(
						"pyproject.toml",
						"setup.py",
						"setup.cfg",
						"requirements.txt",
						".git"
					),
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},

		templ = {},

		dartls = {
			settings = {
				dart = {
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
						vim.fn.expand("$HOME/develop/flutter/"),
					},
				},
			},
		},
	}

	for server, config in pairs(servers) do
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end
