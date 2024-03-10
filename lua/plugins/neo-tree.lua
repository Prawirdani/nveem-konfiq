return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>e", ":Neotree<CR>", { desc = "Toggle File Tree" })
        require("neo-tree").setup({
            window = {
                position = "left",
                width = 30,
            },
        })
    end,
}
