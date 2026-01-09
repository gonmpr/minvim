-- popup autocomplete, use tab to navigate
vim.opt.pumheight = 3
vim.opt.completeopt = { "menuone", "popup", "fuzzy","noselect" }
vim.opt.complete = ".,b"

vim.api.nvim_create_autocmd('InsertCharPre', {
  callback = function()
    if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
      return
    end

    local key = vim.keycode('<C-n>')
    vim.api.nvim_feedkeys(key, 'm', false)
    end
})

vim.keymap.set("i", "<tab>", function()
  local key = vim.keycode('<tab>')
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-n>")
  end
  vim.api.nvim_feedkeys(key, 'n', false)
end, {})


