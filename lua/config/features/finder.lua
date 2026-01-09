-- Recursive search 
vim.opt.path = {
  ".",
  "lua",
  "src",
  "**",
}
-- wildmenu 
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"


-- ignore
vim.opt.wildignore = {
    "*/",
  "node_modules/**",
  ".git/**",
  "target/**",
  "dist/**",
  "*.o", "*.obj",
}

vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = 0
vim.opt.updatetime = 200
vim.opt.redrawtime = 10000

