
# MINVIM
A minimal approach to nvim, no plugins, no lsp.


### Leader keys
- `<leader>` = Space

### Insert mode
- `jj` → exit insert mode

### Navigation
- `<Tab>` → next buffer
- `<S-Tab>` → save (if modified) and close current buffer
- - `<leader>e` → open/close netrw in left split (20%)

### Ephemeral terminal
- `<leader>t` → open terminal buffer
- `<S-Tab>` (terminal mode) → exit terminal and return to previous buffer

### Code navigation
- `<leader>g` → go to definition (custom implementation)

### Editing behavior
- visual mode line move:
  - `J` → move line down
  - `K` → move line up

