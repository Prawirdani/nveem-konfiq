return {
    {
        "tpope/vim-fugitive",

        vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { desc = "Git Status" }),
        vim.keymap.set("n", "<leader>gl", ":Git log --oneline<CR>", { desc = "Git Log" }),
        vim.keymap.set("n", "<leader>gco", ":Git checkout ", { desc = "Git Checkout" }),
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()

            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })
        end,
    },
}
