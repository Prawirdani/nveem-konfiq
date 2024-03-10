return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            -- Lua Language Server
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            -- Typecript Language Server
            lspconfig.tsserver.setup({ capabilities = capabilities })
            -- Golang LS
            lspconfig.gopls.setup({ capabilities = capabilities })
            -- TailwindCSS LS
            lspconfig.tailwindcss.setup({ capabilities = capabilities })
            -- Svelte LS
            lspconfig.svelte.setup({ capabilities = capabilities })
            -- SQL LS
            lspconfig.sqlls.setup({ capabilities = capabilities })

            -- Keymap
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Hover Code" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definitions" })
            vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        end,
    },
}
