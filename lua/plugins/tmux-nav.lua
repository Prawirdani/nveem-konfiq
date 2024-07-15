return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	config = function()
		vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "TMUX Navigate Left" })
		vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "TMUX Navigate Down" })
		vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "TMUX Navigate Up" })
		vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "TMUX Navigate Right" })
	end,
}
