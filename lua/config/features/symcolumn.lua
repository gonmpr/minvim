
local ns = vim.api.nvim_create_namespace("sym_column")

local GUIDE_COL  = 80
local GUIDE_CHAR = "│"
local GUIDE_HL   = "NonText"

local function draw()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  if vim.bo[buf].buftype ~= "" then
    return
  end

  local start = vim.fn.line("w0") - 1
  local finish = vim.fn.line("w$") - 1

  for l = start, finish do
    local line = vim.api.nvim_buf_get_lines(buf, l, l + 1, false)[1] or ""
    if #line < GUIDE_COL then
      vim.api.nvim_buf_set_extmark(buf, ns, l, 0, {
        virt_text = { { GUIDE_CHAR, GUIDE_HL } },
        virt_text_win_col = GUIDE_COL - 1,
        hl_mode = "combine",
      })
    end
  end
end

vim.api.nvim_create_autocmd(
  {
    "BufEnter",
    "WinScrolled",
    "CursorMoved",
    "CursorMovedI",
    "TextChanged",
    "TextChangedI",
    "VimResized",
  },
  { callback = draw }
)
