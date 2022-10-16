local M = {}

local cmd = vim.cmd
local opt = vim.opt

local modes = {
  	["n"] = { "NORMAL", "NormalMode" },
  	["i"] = { "INSERT", "InsertMode" },
	["c"] = { "CMD",    "CmdMode"}
}

cmd('hi! NormalMode gui=bold guifg=#a6e3a1')
cmd('hi! InsertMode gui=bold guifg=#89b4fa')
cmd('hi! Separator guibg=NONE guifg=#FFFFFF')

M.mode = function()
	local m = vim.api.nvim_get_mode().mode
	local current_mode = "%#" .. modes[m][2] .. "#" .. modes[m][1]
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

		if count ~= 0 then
			ret = ret .. " %#LspDiagnostics" .. level .. "#" .. ico .. "%#Normal#" .. count
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

return M
