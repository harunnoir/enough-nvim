STYLUA ?= stylua
NVIM ?= nvim

.PHONY: format check test

format:
	$(STYLUA) init.lua lua

check:
	$(STYLUA) --check init.lua lua
	luac -p init.lua
	find lua -name '*.lua' -print0 | xargs -0 luac -p

test:
	NVIM_LOG_FILE=/tmp/enough-nvim-test.log $(NVIM) --headless \
		-c 'lua print("OK")' -c 'qa!'
