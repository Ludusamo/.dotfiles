function toggle_todo()
  local current_line = vim.api.nvim_get_current_line()
  -- yyyy-mm-dd
  date_pattern = "(%d%d%d%d%-%d%d%-%d%d)"
  _, _, priority, checkbox, start_date, rest = 
    string.find(current_line,
      -- <Priority> <[ ]|[x]>
      "(%u)%s(%[[%sx]%])" 
      .. "%s"
      -- <Start Date>
      .. date_pattern
      .. "(.*)"
    )
  checked = checkbox == "[x]"
  if checked then
    _, _, end_date, rest = string.find(rest, date_pattern .. "%s" .. "(.*)")
    amended_line = priority .. " [ ] " .. start_date .. " " .. rest
  else
    amended_line = priority .. " [x] " .. start_date .. " " .. os.date("%Y-%m-%d") .. rest
  end
  vim.api.nvim_set_current_line(amended_line)
end

vim.keymap.set('n', '<leader>d', toggle_todo, { buffer = true })
