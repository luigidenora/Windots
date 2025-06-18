vim.g.mapleader = " "
-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP Hover" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to Implementation" })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Symbol References" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Go to Next Diagnostic" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Open Diagnostic Float" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Go to Previous Diagnostic" })
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, { buffer = ev.buf, desc = "Format File" })
    -- need the Tab here :
    --
    --
  end,
})

-- custom
vim.keymap.set('n', '<leader>ee', vim.cmd.Ex, { desc = "Open File Explorer" })
vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostic<cr>")
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set('n', '<C-s>', vim.cmd.w, { desc = "Save File" })

vim.keymap.set('n', '<leader>oi', function()
  vim.lsp.buf.execute_command({
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
  })
end, { desc = 'Organize Imports (TS)' })
-- UndoTree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
