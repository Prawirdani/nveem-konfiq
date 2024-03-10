return {
    "nvimtools/none-ls.nvim",
    config = function()
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        local null_ls = require("null-ls")
        local b = null_ls.builtins
        null_ls.setup({
            sources = {
                b.formatting.stylua,
                -- JS/TS
                b.formatting.prettier.with({
                    filetypes = {
                        "html",
                        "javascript",
                        "javascriptreact",
                        "json",
                        "svelte",
                        "typescript",
                        "typescriptreact",
                    },
                }),

                b.formatting.goimports,

                -- b.diagnostics.eslint_d,
                -- Python
                b.formatting.black,
            },

            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            vim.lsp.buf.format({})
                        end,
                    })
                end
            end,
        })

        -- Keymap
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
    end,
}
