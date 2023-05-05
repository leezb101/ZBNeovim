local M = {}

M.keyAttach = function(bufnr)
  local opt = { noremap = true, silent = true, buffer = bufnr }

  print('我正在进行绑定')
  keymap('n', 'gp', '<CMD>lua vim.diagnostic.open_float()<CR>')
  keymap("n", 'gj', "<CMD>lua vim.diagnostic.goto_next()<CR>")
  keymap("n", 'gk', "<CMD>lua vim.diagnostic.goto_prev()<CR>")
  keymap("n", 'gl', "<CMD>lua Telescope loclist<CR>")

  -- lsp
  keymap("n", 'gd', require("telescope.builtin").lsp_definitions, opt)
  keymap("n", 'gD', vim.lsp.buf.declaration, opt)
  keymap("n", 'gh', vim.lsp.buf.hover, opt)
  keymap("n", 'gi', require("telescope.builtin").lsp_implementations, opt)
  keymap(
    "n",
    'gr',
    "<CMD>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_ivy())<CR>",
    opt
  )

  keymap("n", '<leader>rn', "<CMD>lua vim.lsp.buf.rename()<CR>", opt)
  keymap("n", '<leader>ca', "<CMD>lua vim.lsp.buf.code_action()<CR>", opt)
  keymap("n", '<leader>f', "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", opt)
end

M.disableFormat = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

M.flags = {
  debounce_text_changes = 150,
}

return M
