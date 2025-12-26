---------
--Theme--
---------

vim.cmd.colorscheme("habamax")

-- Cursor blink
vim.opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:ver25,o:hor20,a:blinkwait700-blinkoff400-blinkon250"

-- matching color
vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FFFFFF', bg = 'NONE',})

--------------------
--General-settings--
--------------------


-- Basic settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                         -- Highlight current line
vim.opt.wrap = false                               -- Don't wrap lines
vim.opt.scrolloff = 8                              -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor


-- Indentation
vim.opt.tabstop = 4                                -- Tab width
vim.opt.shiftwidth = 4                             -- Indent width
vim.opt.softtabstop = 4                            -- Soft tab stop
vim.opt.expandtab = true                           -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type


-- Visual settings
vim.opt.termguicolors = true                       -- Enable 24-bit colors
vim.opt.signcolumn = "auto"                          -- Always show sign column
-- vim.opt.colorcolumn = "80"                         -- Show column at 100 characters
vim.opt.cmdheight = 1                              -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
vim.opt.showmode = false                           -- Don't show mode in command line 
vim.opt.conceallevel = 0                           -- Don't hide markup 
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
vim.opt.lazyredraw = true                          -- Don't redraw during macros
vim.opt.synmaxcol = 300                            -- Syntax highlighting limit



-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save


-- Behavior settings
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.autochdir = false                          -- Don't auto change directory
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.mouse = "a"                                -- Enable mouse support
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                         -- Set encoding
vim.opt.path:append("**")                          -- include subdirectories in search


-----------
--Require--
-----------


require("config.explorer")
require("config.autocomplete")
require("config.statusbar")


----------------
--Key mappings--
----------------


vim.g.mapleader = " "                              -- Set leader key to space
vim.g.maplocalleader = " "                         -- Set local leader key (NEW)


--remap <Esc> to jj
vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })


------------
--Behavior--
------------


-- Automatically close quotes, brackets, etc.
vim.keymap.set('i', "'", "''<left>", { noremap = true, silent = true })
vim.keymap.set('i', '"', '""<left>', { noremap = true, silent = true })
vim.keymap.set('i', "(", "()<left>", { noremap = true, silent = true })
vim.keymap.set('i', "[", "[]<left>", { noremap = true, silent = true })
vim.keymap.set('i', "{", "{}<left>", { noremap = true, silent = true })


-- Replace all instances of highlighted words
vim.keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")			


-- Move current line down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")	
-- Move current line up
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")	


-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


-- Open netrw(file explorer) in 20% split in tree view
vim.keymap.set("n", "<leader>e", ":20Lexplore<CR>", { desc = "Open left side file explorer"})


-- Center screen when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })


-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })


-- Better window navigation
vim.keymap.set("n", "<leader>w", function()
    local win_count = #vim.api.nvim_tabpage_list_wins(0)
    if win_count == 1 then
        vim.cmd("vsplit")
    else
        vim.cmd("wincmd w")
    end
end, { desc = "Create window or cycle windows" })


-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local line = mark[1]
    local ft = vim.bo.filetype
    if line > 0 and line <= lcount
      and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
      and not vim.o.diff then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})



-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})


---------------
--Performance--
---------------


vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
