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
vim.keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")			


-- Move current line down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")	
-- Move current line up
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")	


-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Save and close buffer
vim.keymap.set("n", "<leader>q", function()
  if vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("bd")
end, { desc = "Save if needed & close buffer" })


-- open terminal 
--vim.keymap.set("n", "<leader>t", function()
--  vim.cmd("terminal")
--  vim.bo.bufhidden = "wipe"
--  vim.bo.swapfile = false
--  vim.bo.buflisted = false
--  vim.cmd("startinsert")
--end, { desc = "Open ephemeral terminal" })
--
-- close terminal 
--vim.keymap.set("t", "<S-Tab>",
--  "<C-\\><C-n>:buffer #<CR>",
--  { desc = "close terminal" }
--)
--

-- Open netrw(file explorer) in 20% split in tree view
vim.keymap.set("n", "<leader>e", ":20Lexplore<CR>", { desc = "Open left side file explorer"})

