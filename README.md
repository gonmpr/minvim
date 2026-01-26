# MINVIM
A minimal approach to Neovim.  
No plugins, no LSP. Just core features and small Lua modules.
requires NVIM 0.11+

## Leader key
- `<leader>` = Space

## Insert mode
- `jj` → exit insert mode

## Buffer navigation
- `<Tab>` → next buffer
- `<S-Tab>` → previous buffer

some buffers are ephemerals, they autoclose when you leave them,
ephemeral buffers only can be leave using `<S-Tab>` or `<Tab>`,
except the floating bufers, which can be leave only using `<S-Tab>`

## File explorer
- `<leader>e` → open explorer in new buffer (ephemeral) 

## File finder
- `<leader>f` → fuzzy find files (requires "fzf" installed)

## Terminal
- `<leader>t` → open ephemeral floating terminal  
  (buffer is wiped on close, always starts in insert mode)

## Code navigation
- `]d` → go to definition  
- `[d` → go back  
  (custom implementation, no LSP)

## Editing behavior

- Visual mode replace:
  - `r` → replace selection
- Visual mode line move:
  - `J` → move line down
  - `K` → move line up

