local palette = require("config.colors.habamax").palette

vim.cmd("highlight StatusNorm guibg=" .. palette.black .. " guifg=" .. palette.black)
vim.cmd("highlight StatusLineNum guibg=" .. palette.yellow .. " guifg=" .. palette.black)
vim.cmd("highlight StatusType guibg=" .. palette.white .. " guifg=" .. palette.black)
vim.cmd("highlight StatusPercent guibg=" .. palette.white .. " guifg=" .. palette.black)
vim.cmd("highlight StatusBuffer guibg=" .. palette.black .. " guifg=" .. palette.cyan)

vim.cmd("highlight StatusModeNorm guibg=" .. palette.yellow .. " guifg=" .. palette.black)
vim.cmd("highlight StatusModeInsert guibg=" .. palette.red .. " guifg=" .. palette.black)
vim.cmd("highlight StatusModeVisual guibg=" .. palette.purple .. " guifg=" .. palette.black)
vim.cmd("highlight StatusModeReplace guibg=" .. palette.white .. " guifg=" .. palette.black)
vim.cmd("highlight StatusModeCommand guibg=" .. palette.blue .. " guifg=" .. palette.black)
vim.cmd("highlight StatusModeTerm guibg=" .. palette.bright_white .. " guifg=" .. palette.black)

local mode_hl = {
  n  = "StatusModeNorm",
  i  = "StatusModeInsert",
  v  = "StatusModeVisual",
  V  = "StatusModeVisual",
  [""] = "StatusModeVisual",
  R  = "StatusModeReplace",
  c  = "StatusModeCommand",
  t  = "StatusModeTerm",
}

local mode_label = {
  n  = " NORMAL ",
  i  = " INSERT ",
  v  = " VISUAL ",
  V  = " V-LINE ",
  [""] = " V-BLOCK ",
  R  = " REPLACE ",
  c  = " COMMAND ",
  t  = " >:_ ",
}

local function update_mode_colors()
  local m = vim.api.nvim_get_mode().mode:sub(1, 1)
  return "%#" .. (mode_hl[m] or "StatusModeNorm") .. "#"
end

local function mode_text()
  local m = vim.api.nvim_get_mode().mode:sub(1, 1)
  return mode_label[m] or m
end

local buffers_cache = ""
local buffers_dirty = true

local function get_buffers()
  if not buffers_dirty then
    return buffers_cache
  end

  local buffers = {}
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf)
       and vim.bo[buf].buflisted then

      local name = vim.fn.fnamemodify(
        vim.api.nvim_buf_get_name(buf),
        ":t"
      )

      if buf == current then
        table.insert(
          buffers,
          "%#StatusLineNum# " .. name .. " %#StatusNorm#"
        )
      else
        table.insert(
          buffers,
          "%#StatusBuffer# " .. name .. " %#StatusNorm#"
        )
      end
    end
  end

  buffers_cache = table.concat(buffers, "%#StatusNorm# ")
  buffers_dirty = false
  return buffers_cache
end

-- statusline 
function _G.Statusline()
  return table.concat {
    "%#StatusLineNum#",
    "%#StatusNorm# ",
    update_mode_colors(),
    mode_text(),
    "%#StatusNorm# ",
    "%#StatusNorm# " .. get_buffers() .. " ",
    "%= ",
    "%#StatusNorm# ",
    "%#StatusType# %Y ",
    "%#StatusNorm# ",
    "%#StatusPercent# %p%% ",
    "%#StatusNorm# ",
  }
end

vim.o.statusline = "%!v:lua.Statusline()"


local augroup = vim.api.nvim_create_augroup("StatusbarBuffers", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufAdd", "BufDelete", "BufEnter" },
  {
    group = augroup,
    callback = function()
      buffers_dirty = true
    end,
  }
)
