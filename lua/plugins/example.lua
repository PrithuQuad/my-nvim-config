if true then
  return {}
end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {

      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "tzachar/cmp-tabnine", build = "./install.sh", config = true },
  --   },
  -- },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     -- DAP configuration for JavaScript
  --     local dap = require("dap")
  --
  --     -- Node.js (JavaScript) Debug Adapter
  --     dap.adapters.node2 = {
  --       type = "executable",
  --       command = "node",
  --       args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/out/src/nodeDebug.js" },
  --     }
  --
  --     dap.configurations.javascript = {
  --       {
  --         type = "node2",
  --         request = "launch",
  --         name = "Launch JavaScript file",
  --         program = "${file}", -- Debug the currently open file
  --         cwd = "${workspaceFolder}", -- Set working directory
  --         runtimeExecutable = "node", -- Adjust if you use a specific Node.js version
  --         sourceMaps = true, -- Enable source maps for better debugging
  --       },
  --     }
  --
  --     -- React/JSX/TSX support (optional, if you're working with React)
  --     dap.configurations.javascriptreact = dap.configurations.javascript
  --     dap.configurations.typescriptreact = dap.configurations.javascript
  --   end,
  -- },
  --
  -- -- DAP UI (graphical interface)
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   config = function()
  --     local dapui = require("dapui")
  --     dapui.setup()
  --
  --     -- Open the UI when debugging starts
  --     require("dap").listeners.after["dap.start"] = function()
  --       dapui.open()
  --     end
  --
  --     -- Close the UI when debugging ends
  --     require("dap").listeners.before["dap.terminate"] = function()
  --       dapui.close()
  --     end
  --   end,
  -- },
  --
  -- -- DAP Virtual Text (for inline text in the editor)
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --   end,
  -- },
  --
  -- -- JS Debug Adapter via Mason (optional for automatic installation)
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require("mason").setup()
  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "js-debug-adapter" }, -- Install the JS Debug Adapter via Mason
  --     })
  --   end,
  -- },

  -- Telescope DAP Extension (optional)
  {
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      require("telescope").load_extension("dap")
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
