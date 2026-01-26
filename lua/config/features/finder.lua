
local palette = require("config.colors.habamax").palette

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.gray, bg = "NONE" })

local M = {}

local function normalize_path(path)
  if not path or path == "" then
    return nil
  end

  -- remove leading ./ if present
  path = path:gsub("^%./", "")

  return path
end

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
  local _, win = open_floating_window()
  local tmpfile = vim.fn.tempname()

  local cmd = [[
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git ls-files --cached --others --exclude-standard
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
      "FZF_DEFAULT_COMMAND=\"" .. cmd .. "\" fzf --print-query > " .. tmpfile,
    },
    {
      on_exit = function()
        pcall(vim.api.nvim_win_close, win, true)

        local lines = vim.fn.readfile(tmpfile)
        vim.fn.delete(tmpfile)

        if #lines == 0 then
          return
        end

        local query = normalize_path(lines[1])
        local file  = normalize_path(lines[2]) or query

        if file and file ~= "" and vim.fn.filereadable(file) == 1 then
          vim.cmd.edit(vim.fn.fnameescape(file))
        end
      end,
    }
  )

  vim.cmd.startinsert()
end

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
  desc = "Close terminal(fzf)",
})

-- keymap
vim.keymap.set("n", "<leader>f", M.find, {
  desc = "Find or create file (fzf)",
})

return M
