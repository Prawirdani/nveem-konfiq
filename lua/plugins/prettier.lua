return {
	"MunifTanjim/prettier.nvim",
	config = function()
		require("prettier").setup({
			bin = "prettier", -- or `'prettierd'` (v0.23.3+)
			filetypes = {
				"css",
				"graphql",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"less",
				"markdown",
				"svelte",
				"scss",
				"typescript",
				"typescriptreact",
				"yaml",
			},
		})
	end,
}
