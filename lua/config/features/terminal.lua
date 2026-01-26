local palette = require("config.colors.habamax").palette

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.gray, bg = "NONE" })

local M = {}



-- =========================
-- Create floating terminal
-- =========================
local function open_floating_terminal()
  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- open terminal
  vim.cmd("terminal")
  vim.cmd("startinsert")

  -- mark buffer as disposable
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.buflisted = false

  return buf, win
end

-- =========================
-- Toggle terminal (always new)
-- =========================
function M.toggle()
  local buf = vim.api.nvim_get_current_buf()

  -- if we're already in a terminal buffer, close it
  if vim.bo[buf].buftype == "terminal" then
    vim.cmd("bd!")
    return
  end

  open_floating_terminal()
end

-- =========================
-- Keymaps
-- =========================

-- open terminal
vim.keymap.set("n", "<leader>t", M.toggle, {
  desc = "Open floating terminal",
})

-- change buffer closes terminal (normal + terminal mode)
vim.keymap.set({ "n", "t" }, "<S-Tab>", function()
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo[buf].buftype ~= "terminal" then
    return
  end

  -- exit terminal mode if needed
  if vim.fn.mode() == "t" then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
      "n",
      false
    )
  end

  vim.cmd("bd!")
end, {
  desc = "Close terminal",
})

-- =========================
-- User command (optional)
-- =========================
vim.api.nvim_create_user_command("Floaterminal", M.toggle, {})

return M
