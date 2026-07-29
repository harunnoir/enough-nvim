STYLUA ?= stylua
NVIM ?= nvim

.PHONY: format check test

format:
	$(STYLUA) init.lua lua tests

check:
	$(STYLUA) --check init.lua lua tests
	luac -p init.lua
	find lua -name '*.lua' -print0 | xargs -0 luac -p
	find tests -name '*.lua' -print0 | xargs -0 luac -p

test:
	XDG_CACHE_HOME=/tmp/enough-nvim-cache XDG_STATE_HOME=/tmp/enough-nvim-state \
		NVIM_LAZY_LOCKFILE=/tmp/enough-nvim-test-lock.json \
		$(NVIM) --headless -c 'luafile tests/smoke.lua' -c 'lua print("OK")' -c 'qa!'
	XDG_CACHE_HOME=/tmp/enough-nvim-cache XDG_STATE_HOME=/tmp/enough-nvim-state \
		NVIM_LAZY_LOCKFILE=/tmp/enough-nvim-test-lock.json \
		$(NVIM) --headless . \
		-c "lua assert(vim.bo.filetype == 'oil', 'nvim . did not open Oil')" \
		-c 'qa!'
