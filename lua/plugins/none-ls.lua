return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local b = null_ls.builtins

		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		local event = "BufWritePre" -- or "BufWritePost"
		local async = event == "BufWritePost"
		null_ls.setup({
			sources = {
				-- Lua
				b.formatting.stylua,
				-- JS/TS
				require("none-ls.diagnostics.eslint_d"),
				b.formatting.prettierd.with({
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
				b.diagnostics.ruff,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })

					-- format on save
					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
					vim.api.nvim_create_autocmd(event, {
						buffer = bufnr,
						group = group,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = async })
						end,
						desc = "[lsp] format on save",
					})
				end

				if client.supports_method("textDocument/rangeFormatting") then
					vim.keymap.set("x", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })
				end
			end,
		})

		-- Keymap
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
	end,
}
