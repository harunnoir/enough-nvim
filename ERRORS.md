# 2026-06-25

```sh
05:38:27 PM msg_show.echomsg BufReadPost Autocommands for "*": Vim(append):Lua callback: /usr/share/nvim/runtime/filetype.lua:28: BufReadPost Autocommands for "*"..FileType Autocommands for "make": Vim(append):Lua callback: /usr/share/nvim/runtime/lua/vim/treesitter.lua:460: Parser could not be created for buffer 3 and language "make"
stack traceback:
	[C]: in function 'assert'
	/usr/share/nvim/runtime/lua/vim/treesitter.lua:460: in function 'start'
	/home/x/.config/nvim/lua/plugins/core.lua:57: in function </home/x/.config/nvim/lua/plugins/core.lua:56>
	[C]: in function 'nvim_cmd'
	/usr/share/nvim/runtime/filetype.lua:28: in function </usr/share/nvim/runtime/filetype.lua:27>
	[C]: in function 'pcall'
	[string "?"]:1648: in function <[string "?"]:1628>
	[C]: in function '_with'
	/usr/share/nvim/runtime/filetype.lua:27: in function </usr/share/nvim/runtime/filetype.lua:10>
	[C]: at 0x55e48a50f450
	[C]: in function 'pcall'
	/home/x/.local/share/nvim/lazy/oil.nvim/lua/oil/init.lua:768: in function 'callback'
	...ocal/share/nvim/lazy/oil.nvim/lua/oil/adapters/files.lua:279: in function 'fn'
	[string "?"]:273: in function <[string "?"]:272>
stack traceback:
	[C]: in function '_with'
	/usr/share/nvim/runtime/filetype.lua:27: in function </usr/share/nvim/runtime/filetype.lua:10>
	[C]: at 0x55e48a50f450
	[C]: in function 'pcall'
	/home/x/.local/share/nvim/lazy/oil.nvim/lua/oil/init.lua:768: in function 'callback'
	...ocal/share/nvim/lazy/oil.nvim/lua/oil/adapters/files.lua:279: in function 'fn'
	[string "?"]:273: in function <[string "?"]:272>
 
 ``` 
