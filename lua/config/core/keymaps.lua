-- Leader key
vim.g.mapleader = " "      
vim.g.maplocalleader = " "  

--remap <Esc> to jj
vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })

-- Center screen when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })


-- Automatically close quotes, brackets, etc.
vim.keymap.set('i', "'", "''<left>", { noremap = true, silent = true })
vim.keymap.set('i', '"', '""<left>', { noremap = true, silent = true })
vim.keymap.set('i', "(", "()<left>", { noremap = true, silent = true })
vim.keymap.set('i', "[", "[]<left>", { noremap = true, silent = true })
vim.keymap.set('i', "{", "{}<left>", { noremap = true, silent = true })


-- Replace all instances of highlighted words
vim.keymap.set("v", "r", "\"hy:%s/<C-r>h//g<left><left>")			

-- Move current line down 
vim.keymap.set("v", "J", ":m '>+1<CR>gv") 
-- Move current line up 
vim.keymap.set("v", "K", ":m '<-2<CR>gv")


-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Open explorer
vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bd")
  else
    vim.cmd("Ex")
  end
end, { silent = true, desc = "Toggle explorer (netrw)" })
