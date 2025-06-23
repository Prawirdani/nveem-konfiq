-- Main LSP Configuration
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local telescope = require 'telescope.builtin'

          -- map('gd', telescope.lsp_definitions, '[G]oto [D]efinition') -- NOTE: vim.lsp.util.jump_to deprecated and this shit ain't patched yed
          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gr', telescope.lsp_references, '[G]oto [R]eferences')
          map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostic', { 'n', 'x' })
          map('<leader>ch', vim.lsp.buf.hover, '[C]ode [H]over', { 'n', 'x' })
          map('<leader>ce', function()
            vim.diagnostic.jump {
              forward = true,
              float = true,
              count = 1,
            }
          end, '[C]ode [E]rror', { 'n', 'x' })

          vim.diagnostic.config {
            float = {
              focusable = true,
              border = 'rounded',
              source = true,
            },
            virtual_text = true,
            underline = true,
            signs = true,
          }

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local servers = {
        gopls = {
          gofumpt = true,
        },
        biome = {},
        pyright = {
          -- Don't know what happened, but pyright wont active unless a dir has initalized git. weird huh?
          -- This basically tells pyright to use the current directory as the root directory
          -- root_dir = function()
          --   return vim.fn.expand '%:p:h'
          -- end,
          -- settings = {
          --   pyright = {
          --     disableOrganizeImports = true,
          --   },
          --   python = {
          --     analysis = {
          --       autoSearchPaths = true,
          --       useLibraryCodeForTypes = true,
          --       diagnosticMode = 'workspace',
          --     },
          --   },
          -- },
        },
        ruff = {
          settings = {
            args = {},
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        -- ts_ls = {
        --   init_options = {
        --     hostInfo = 'neovim',
        --     preferences = {
        --       includeCompletionsForModuleExports = true,
        --       includeCompletionsForImportStatements = true,
        --       importModuleSpecifier = 'non-relative',
        --     },
        --   },
        -- },
      }

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})

      -- No need to include item from servers table, as they are already included in ensure_installed
      -- vim.list_extend(ensure_installed, {
      --   -- Lsp's
      --   -- 'stylua',
      --   -- 'html-lsp',
      --   -- 'tailwindcss-language-server',
      --   'biome',
      --   'gopls'
      --   -- 'emmet-language-server',
      --   -- 'eslint',
      --   -- Formmatters
      --   -- 'sql-formatter',
      --   -- 'goimports',
      --   -- 'gofumpt',
      --   -- 'golines',
      --
      --   -- Dap
      --   -- 'debugpy',
      -- })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_enable = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  -- LuaLS for Neovim config
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
}
