return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local theme = require 'lualine.themes.seoul256'
    theme.normal.c.bg = '#282727'

    for _, mode in pairs { 'normal', 'insert', 'visual', 'replace' } do
      theme[mode].b.bg = '#3b3a3a'
    end

    -- status-style "bg=#282727,fg=#c8c093"
    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- theme = 'seoul256',
        theme = theme,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'diff' },
        lualine_x = { 'diagnostics', 'filename' },
        -- lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'location' },
        lualine_z = {},
      },
    }
  end,
}
