return {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        require("which-key").setup()

        require("which-key").register({
            ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
            ["<leader>e"] = { name = "File Tree", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
            ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
        })
    end,
}
