local M = {}

function M.setup()
	local plugin_dir = vim.fn.stdpath("config") .. "/lua/beeploop/plugins"

	local files = vim.fn.readdir(plugin_dir, function(name)
		return name:match("%.lua$") and name ~= "init.lua"
	end)

	table.sort(files)

	for _, file in ipairs(files) do
		local module = "beeploop.plugins." .. file:gsub("%.lua$", "")
		require(module)
	end
end

M.setup()

return M
