function ChangeGitsignsBaseForAllBuffers(base_rev)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buftype") == "" then
      local ok, _ = pcall(function()
        require('gitsigns').change_base(base_rev, { buffer = bufnr })
      end)
    end
  end
end

vim.api.nvim_create_user_command(
  'GitsignsChangeBaseAll',
  function(opts)
    ChangeGitsignsBaseForAllBuffers(opts.args)
  end,
  { nargs = 1, desc = "Change gitsigns base revision for all loaded buffers" }
)
