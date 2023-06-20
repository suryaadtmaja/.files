-- local status, null_ls = pcall(require, "null-ls")
-- if (not status) then return end
--
-- local diagnostics = null_ls.builtins.diagnostics
-- local formatting = null_ls.builtins.formatting
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.eslint_d.with({
--             diagnostics_format = '[eslint]\n #{m}\n(#{c})'
--         }),
--         null_ls.builtins.diagnostics.fish,
--         diagnostics.tsc,
--         formatting.eslint_d
--     },
--     on_attach = function(client, bufnr)
--       -- if client.name == "tsserver" then
--       --   client.resolved_capabilities.document_formatting = false
--       -- end
--       if client.server_capabilities.documentFormattingProvider then
--         client.server_capabilities.documentFormattingProvider = false
--         vim.api.nvim_clear_autocmds { buffer = bufnr, group = augroup_format }
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup_format,
--             -- buffer = 0,
--             callback = function()
--               vim.lsp.buf.formatting_seq_sync()
--             end
--         })
--       end
--     end,
-- })
--
-- -- Auto commands
-- vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])
--
local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics



local sources = {
    formatting.eslint_d,
    formatting.stylua,
    formatting.rustfmt,
    code_actions.eslint_d,
    diagnostics.eslint_d
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
      bufnr = bufnr,
      filter = function(client)
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        return client.name == "null-ls"
      end,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- vim.lsp.buf.format({ bufnr = bufnr })
          lsp_formatting(bufnr)
        end,
    })
  end
end

null_ls.setup({
    sources = sources,
    on_attach = on_attach
})
