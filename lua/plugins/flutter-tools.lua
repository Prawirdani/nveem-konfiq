return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local group = vim.api.nvim_create_augroup("dart_format_on_save", { clear = false })
		require("flutter-tools").setup({
			-- dart_path = "/usr/bin/dart",
			flutter_path = "/usr/bin/flutter/bin/flutter",

			lsp = {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									async = false,
								})
							end,
						})
					end
				end,
			},
		})
	end,
}
