local palette = require("config.colors.habamax").palette

-- netrw core behavior
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3      -- tree view
vim.g.netrw_browse_split = 4
vim.g.netrw_keepdir = 0
vim.g.netrw_fastbrowse = 0
vim.g.netrw_sort_sequence = [[[\/]$,*]]


local hl = {
  netrwDir       = palette.red,
  netrwClassify  = palette.cyan,
  netrwExe       = palette.yellow,
  netrwSymLink   = palette.cyan,
  netrwMarkFile  = palette.red,
}

for group, color in pairs(hl) do
  vim.api.nvim_set_hl(0, group, { fg = color })
end

-- closes netrw and the buffer automatically
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype ~= "netrw" then
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[b].filetype == "netrw" then
          pcall(vim.api.nvim_buf_delete, b, { force = true })
        end
      end
    end
  end,
})

