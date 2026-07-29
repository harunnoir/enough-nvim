# Architecture

enough-nvim follows the Unix idea of small parts with clear jobs. The goal is
not the smallest possible file count; it is the smallest structure that stays
obvious as the configuration grows.

## Boundaries

- `init.lua` delegates startup to `lua/config/init.lua`.
- `lua/config/` owns editor policy: options, diagnostics, autocommands, plugin
  bootstrap, and GUI behavior.
- `lua/maps/` is the single index of native and plugin keybindings.
- `lua/lsp/` defines and enables native Neovim LSP servers.
- `lua/plugins/` contains flat, concern-based Lazy specs.
- `bin/` contains executable setup tasks.
- `docs/` explains decisions and workflows.

Native maps are installed by `maps/init.lua`. Plugin map modules return
Lazy-compatible `keys` tables, which plugin specs consume. This keeps the whole
keyboard design readable in one directory without sacrificing lazy loading.

## Naming

- Prefer short, established domain names such as `nav`, `cmp`, `lang`, and `ts`.
- Spell out a name when its abbreviation would be ambiguous.
- Name files by responsibility, not by the implementation used today.
- Use `extras.lua` only for independent, optional tools.
- Avoid nested plugin directories until a concern genuinely needs multiple
  internal modules.

## Comments

Comments explain constraints or intent that the code cannot express. They do
not narrate obvious Lua. Plugin names, `desc` fields, and descriptive variables
should carry most of the documentation.

## Change rules

1. Prefer native Neovim behavior before adding a plugin.
2. Add one capability in one obvious place.
3. Avoid overlapping mappings and interchangeable plugins.
4. Preserve the Limei palette and its pinned revision.
5. Keep generated state out of the repository.
6. Run `make check` and `make test` before committing.

Simplicity is the stopping rule: split mixed responsibilities, but do not add
an abstraction merely to remove a few repeated lines.
