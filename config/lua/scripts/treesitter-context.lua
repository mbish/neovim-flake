require('treesitter-context').setup{
  enable = true,
  multiwindow = false,
  max_lines = 0,
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 10, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',
  separator = nil, -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
