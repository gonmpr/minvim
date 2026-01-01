local palette = require("config.colors.habamax").palette


-- netrw config
vim.g.netrw_banner = 0	    			-- gets rid of the annoying banner for netrw
vim.g.netrw_altv = 0					-- change from left splitting to right splitting
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3				-- tree style view in netrw
vim.g.netrw_sizestyle = "H"
vim.g.netrw_sort_sequence = [[[\/]$,*]] -- sort directories first
vim.g.netrw_keepdir = 0
vim.g.netrw_sort_sequence = [[[\/]$,*]]
vim.g.netrw_sizestyle = "H"
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_compress = "gzip"
vim.g.netrw_cursor = 2
vim.g.netrw_preview = 0
vim.g.netrw_alto = 1
vim.g.netrw_fastbrowse = 0

-- directory names 
vim.api.nvim_set_hl(0, "netrwDir", { fg = palette.red })
-- classify symbols "/"
vim.api.nvim_set_hl(0, "netrwClassify", { fg = palette.cyan})
-- executable files
vim.api.nvim_set_hl(0, "netrwExe", { fg = palette.yellow })
-- symlinks 
vim.api.nvim_set_hl(0, "netrwExe", { fg = palette.yellow })
-- marked files 
vim.api.nvim_set_hl(0, "netrwExe", { fg = palette.yellow})

-- closes netrw automatically
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "netrw" then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "netrw" then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end
    end
  end,
})

