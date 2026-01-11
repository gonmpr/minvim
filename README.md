
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

## Buffer / window management
- `<leader>q` → close current buffer   
- `<Esc><Esc>` → exit and close floating buffers 

## File explorer
- `<leader>e` → open netrw in left split (20%, tree view)

## File finder
- `<leader>f` → fuzzy find files (requires "fzf" installed)

## Terminal
- `<leader>t` → open ephemeral floating terminal  
  (buffer is wiped on close, always starts in insert mode)

## Code navigation
- `<leader>g` → go to definition  
  (custom implementation, no LSP)

## Editing behavior
- Visual mode line move:
  - `J` → move line down
  - `K` → move line up
- Center screen on half-page jumps:
  - `<C-d>` / `<C-u>`

## Notes
- color is hardcoded in statusbar, terminal and finder files. (sorry)
- No persistent UI state
- No background processes
- Everything is explicit and hackable
