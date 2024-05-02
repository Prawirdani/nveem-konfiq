return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		requires = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"emmet_language_server",
					"eslint",
					"gopls",
					"html",
					"lua_ls",
					"pyright",
					"sqls",
					"svelte",
					"tailwindcss",
					"tsserver",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		requires = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"black",
					"mypy",
					"prettier",
					"debugpy",
					"eslint_d",
					"ruff",
					"goimports",
				},
			})
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
			-- Python LS
			lspconfig.pyright.setup({ capabilities = capabilities })
			-- TailwindCSS LS
			lspconfig.tailwindcss.setup({ capabilities = capabilities })
			-- Svelte LS
			lspconfig.svelte.setup({ capabilities = capabilities })
			-- SQL LS
			lspconfig.sqlls.setup({ capabilities = capabilities })
			-- HTML LS
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.emmet_language_server.setup({ capabilities = capabilities })
			-- Keymap
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Hover Code" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definitions" })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		end,
	},
}
