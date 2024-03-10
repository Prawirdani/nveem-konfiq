return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                transparent = true,
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
