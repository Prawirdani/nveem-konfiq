return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    name = 'kanagawa',
    config = function()
      require('kanagawa').setup {
        transparent = true,
        terminalColors = true,
        keywordStyle = { italic = false, bold = false },
        commentStyle = { italic = false },
        statementStyle = { bold = false },
        functionStyle = { bold = true },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
      }
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
  },
}
