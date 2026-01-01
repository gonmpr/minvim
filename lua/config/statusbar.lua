local palette = require('config.colors.habamax').palette

-- statusline colors
vim.cmd ('highlight StatusNorm guibg=' .. palette.black .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusLineNum guibg=' .. palette.yellow .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusType guibg=' .. palette.white .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusPercent guibg=' .. palette.white .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusBuffer guibg=' .. palette.black .. ' guifg=' ..palette.cyan) 

--statusline mode colors
vim.cmd ('highlight StatusModeNorm guibg=' .. palette.yellow .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusModeInsert guibg=' .. palette.red .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusModeVisual guibg=' .. palette.purple .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusModeReplace guibg=' .. palette.white .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusModeCommand guibg=' .. palette.blue .. ' guifg=' ..palette.black)
vim.cmd ('highlight StatusModeTerm guibg=' .. palette.bright_white .. ' guifg=' ..palette.black)

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL line",
  [""] = "VISUAL block",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = ">_:",
  ["t"] = ">_:",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusNorm#"
  if current_mode == "n" then
      mode_color = "%#StatusModeNorm#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatusModeInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatusModeVisual#"
  elseif current_mode == "R" then
      mode_color = "%#StatusModeReplace#"
  elseif current_mode == "c" then
      mode_color = "%#StatusModeCommand#"
  elseif current_mode == "t" then
      mode_color = "%#StatusModeTerm#"
  end
  return mode_color
end

-- get the buffers for displaying them
local function get_buffers()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
      local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
      local is_current = buf == vim.api.nvim_get_current_buf()
      
      if is_current then
        table.insert(buffers, "%#StatusModeNorm# " .. name .. " %#StatusNorm#")
      else
        table.insert(buffers, "%#StatusBuffer# " .. name .. " %#StatusNorm#")
      end
    end
  end
  return table.concat(buffers, " ")
end



Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#StatusLineNum#",
    "%#StatusNorm# ",
    update_mode_colors(),
    mode(),
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

function Statusline.inactive()
  return "%#StatusNorm# %F"
end

function Statusline.short()
  return "%#StatusNorm#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
