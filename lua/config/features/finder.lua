local palette = require("config.colors.habamax").palette

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.gray, bg = "NONE" })

local M = {}

local function open_floating_window()
  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

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

  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].buflisted = false

  return buf, win
end

function M.find()
  local buf, win = open_floating_window()
  local tmpfile = vim.fn.tempname()

  local default_cmd = [[
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git ls-files
    else
      find . -type f \
        -not -path '*/.git/*' \
        -not -path '*/__pycache__/*'
    fi
  ]]

  vim.fn.termopen(
    {
      "sh",
      "-c",
      "FZF_DEFAULT_COMMAND=\"" .. default_cmd .. "\" fzf > " .. tmpfile,
    },
    {
      on_exit = function()
        pcall(vim.api.nvim_win_close, win, true)

        local file = vim.fn.readfile(tmpfile)[1]
        vim.fn.delete(tmpfile)

        if file and file ~= "" then
          vim.cmd.edit(vim.fn.fnameescape(file))
        end
      end,
    }
  )

  vim.cmd.startinsert()
end

-- keymap
vim.keymap.set("n", "<leader>f", M.find, {
  desc = "Find file (fzf + git ls-files)",
})

return M
