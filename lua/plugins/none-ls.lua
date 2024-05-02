return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local b = null_ls.builtins

		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		null_ls.setup({
			sources = {
				-- Lua
				b.formatting.stylua,
				-- JS/TS
				b.formatting.prettier.with({
					filetypes = {
						"html",
						"json",
						"svelte",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
				}),

				-- Golang
				b.formatting.goimports,
				-- Python
				b.formatting.black,
				b.formatting.pretty_php,
				require("none-ls.diagnostics.ruff"),
			},
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
								filter = function()
									return client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})

		-- Keymap
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
	end,
}
