return {
	"MunifTanjim/prettier.nvim",
	config = function()
		require("prettier").setup({
			bin = "prettier",
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
			cli_options = {
				single_qoute = true,
				semi = true,
				use_tabs = false,
				print_width = 80,
			},
		})
	end,
}
