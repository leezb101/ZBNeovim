function _G.keymap(mode, lhs, rhs, opts)
  if not lhs or not rhs then
    return
  end

  local keyOpts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  print(lhs)
  if type(lhs) == 'table' then
    for _, x in pairs(lhs) do
      print(x)
      print(rhs)
      vim.keymap.set(mode, x, rhs, keyOpts)
    end
    return
  end
  vim.keymap.set(mode, lhs, rhs, keyOpts)
end
