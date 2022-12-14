local M = {}

local modes = {
	["n"] = { "NORMAL", "NormalMode" },
	["no"] = { "NORMAL", "NormalMode" },
	["niI"] = { "NORMAL", "NormalMode" },
	["niR"] = { "NORMAL", "NormalMode" },
	["niV"] = { "NORMAL", "NormalMode" },

	["v"] = { "VISUAL", "VisualMode" },
	["V"] = { "VISUAL", "VisualMode" },
	[""] = { "VISUAL", "VisualMode" },

	["s"] = { "SELECT", "SelectMode" },
	["S"] = { "SELECT", "SelectMode" },
	[""] = { "SELECT", "SelectMode" },

	["i"] = { "INSERT", "InsertMode" },
	["ic"] = { "INSERT", "InsertMode" },
	["ix"] = { "INSERT", "InsertMode" },

	["R"] = { "REPLACE", "ReplaceMode" },
	["Rv"] = { "REPLACE", "ReplaceMode" },

	["c"] = { "COMMAND", "CmdMode" },
	["cv"] = { "COMMAND", "CmdMode" },
	["ce"] = { "COMMAND", "CmdMode" },

	["r"] = { "PROMPT", "PromptMode" },
	["rm"] = { "PROMPT", "PromptMode" },
	["r?"] = { "PROMPT", "PromptMode" },

	["!"] = { "TERMINAL", "TermMode" },
	["t"] = { "TERMINAL", "TermMode" },
	["nt"] = { "TERMINAL", "TermMode" },
}

M.mode = function()
	local m = vim.api.nvim_get_mode().mode
	local current_mode = "%#" .. modes[m][2] .. "# " .. modes[m][1] .. " %#StatusLineFill#"
	return current_mode
end

M.lsp = function()
	local ret = ""

	local levels = {
		["Error"] = " ",
		["Warn"] = " ",
		["Info"] = " ",
		["Hint"] = " ",
	}

	for level, ico in pairs(levels) do
		local count
		count = #vim.diagnostic.get(0, { severity = level })

		if count ~= 0 then
			ret = ret .. " %#LspDiagnostics" .. level .. "#" .. ico .. "%#StatusLineFill#" .. count
		end
	end

	return ret .. " "
end

M.run = function()
	local str = "%#StatusLineFill#"
	str = str .. M.mode()
	str = str .. "%=%#StatusLineExtra#%#StatusLineFill#"
	str = str .. M.lsp()

	return str
end

M.setup = function()
	vim.o.statusline = "%!v:lua.require('NvRose.base.statusline').run()"
end

return M
