return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		require("which-key").setup()

		require("which-key").add({
			{ "<leader>c",  group = "Code" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d",  group = "Document" },
			{ "<leader>d_", hidden = true },
			{ "<leader>e",  group = "File Tree" },
			{ "<leader>e_", hidden = true },
			{ "<leader>f",  group = "Find" },
			{ "<leader>f_", hidden = true },
			{ "<leader>g",  group = "Git" },
			{ "<leader>g_", hidden = true },
		})
	end,
}
