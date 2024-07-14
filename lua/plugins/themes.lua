return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				transparent = true,
				keywordStyle = { italic = false },
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				theme = "wave",
			})

			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
