local M = {}

-- patterns to search
local function definition_patterns(word)
  return {
    -- Python
    "^%s*def%s+" .. word .. "%s*%(",
    "^%s*class%s+" .. word .. "%s*[:%(]",

    -- Go
    "^%s*func%s+" .. word .. "%s*%(",
    "^%s*func%s*%b()%s*" .. word .. "%s*%(",

    -- C
    "^%s*([%w_]+%s+)*[%w_]+%s*%*?%s*" .. word .. "%s*%(",

    -- variables / simple types
    "^%s*" .. word .. "%s*=",
  }
end

local function search_in_buffer(bufnr, word)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local patterns = definition_patterns(word)

  for i, line in ipairs(lines) do
    for _, pat in ipairs(patterns) do
      if line:match(pat) then
        return i
      end
    end
  end
  return nil
end

function M.goto_definition()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end

  local current_buf = vim.api.nvim_get_current_buf()

  -- 1. Search in current buffer
  local line = search_in_buffer(current_buf, word)
  if line then
    vim.cmd("normal! mZ")
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    return
  end

  -- 2. Search in other buffers
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current_buf and vim.api.nvim_buf_is_loaded(bufnr) then
      local l = search_in_buffer(bufnr, word)
      if l then
        vim.cmd("normal! mZ")
        vim.api.nvim_set_current_buf(bufnr)
        vim.api.nvim_win_set_cursor(0, { l, 0 })
        return
      end
    end
  end

  vim.notify("Definition not found: " .. word, vim.log.levels.INFO)
end

function M.goto_back()
  vim.cmd("normal! `Z")
end

-- mappings
vim.keymap.set("n", "]d", M.goto_definition, {
  desc = "Go to definition",
})

vim.keymap.set("n", "[d", M.goto_back, {
  desc = "Go back",
})

return M
