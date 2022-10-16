local M = {}

local cmd = vim.cmd
local opt = vim.opt

local modes = {
  	["n"]    = { "NORMAL",   "NormalMode" },
  	["no"]   = { "NORMAL",   "NormalMode" },
  	["niI"]  = { "NORMAL",   "NormalMode" },
  	["niR"]  = { "NORMAL",   "NormalMode" },
  	["niV"]  = { "NORMAL",   "NormalMode" },

	["v"]    = { "VISUAL",   "VisualMode" },
	["V"]    = { "VISUAL",   "VisualMode" },
	[""]   = { "VISUAL",   "VisualMode" },

	["s"]    = { "SELECT",   "SelectMode" },
	["S"]    = { "SELECT",   "SelectMode" },
	[""]   = { "SELECT",   "SelectMode" },

  	["i"]    = { "INSERT",   "InsertMode" },
  	["ic"]   = { "INSERT",   "InsertMode" },
  	["ix"]   = { "INSERT",   "InsertMode" },

  	["R"]    = { "REPLACE",  "ReplaceMode" },
  	["Rv"]   = { "REPLACE",  "ReplaceMode" },

	["c"]    = { "COMMAND",  "CmdMode"    },
	["cv"]   = { "COMMAND",  "CmdMode"    },
	["ce"]   = { "COMMAND",  "CmdMode"    },

	["r"]    = { "PROMPT",   "PromptMode" },
	["rm"]   = { "PROMPT",   "PromptMode" },
	["r?"]   = { "PROMPT",   "PromptMode" },

	["!"]    = { "TERMINAL", "TermMode"   },
	["t"]    = { "TERMINAL", "TermMode"   },
	["nt"]   = { "TERMINAL", "TermMode"   },
}

M.mode = function()
	local m = vim.api.nvim_get_mode().mode
	local current_mode = "%#" .. modes[m][2] .. "# " .. modes[m][1]
	return current_mode .. "%#Normal#"
end

M.lsp = function()
	local ret = ""

	local levels = {
		['Error'] = ' ',
		['Warn']  = ' ',
		['Info']  = ' ',
		['Hint']  = ' '
	}

	cmd('hi! link LspDiagnosticsWarn LspDiagnosticsWarning')
	for level, ico in pairs(levels) do
		local count
		count = #vim.diagnostic.get(0, { severity = level })

		ret = ret .. " "

		if count ~= 0 then
			ret = ret .. "%#LspDiagnostics" .. level .. "#" .. ico .. "%#Normal#" .. count
		end
	end

	return ret
end

M.run = function()
	local str = ""

	str = str .. M.mode()
	str = str .. "%=%#StatusLineExtra#"
	str = str .. M.lsp()

	return str
end

M.setup = function()
	-- Lazy load statusline
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		pattern = '*',
		command = [[ sil! setlocal statusline=%!v:lua.require('statusline').run() ]]
	})
end

return M
