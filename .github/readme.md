<h3 align=center> NvRose - statusline </h3>

### Installation

```lua
use {
	"NvRose/statusline.nvim",
 	config = function()
		opt.stl = "%!v:lua.require('statusline').run()"
	end
}
```

### Roadmap
- FIXME:
	- error: E15: Invalid expression: v:lua.require("statusline").run()

### 📜 License
NvRose is released under MIT license, which grants the following permissions:
- Commercial use
- Distribution
- Modification
- Private use
For more details see [license](https://github.com/NvRose/statusline.nvim/license).
