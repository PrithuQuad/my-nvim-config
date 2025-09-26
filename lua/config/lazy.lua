-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--   if vim.v.shell_error ~= 0 then
--     vim.api.nvim_echo({
--       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--       { out, "WarningMsg" },
--       { "\nPress any key to exit..." },
--     }, true, {})
--     vim.fn.getchar()
--     os.exit(1)
--   end
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup({
--   spec = {
--     -- add LazyVim and import its plugins
--     { "LazyVim/LazyVim", import = "lazyvim.plugins" },
--     -- import/override with your plugins
--     { import = "plugins" },
--   },
--   defaults = {
--     -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
--     -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
--     lazy = false,
--     -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
--     -- have outdated releases, which may break your Neovim install.
--     version = false, -- always use the latest git commit
--     -- version = "*", -- try installing the latest stable version for plugins that support semver
--   },
--   install = { colorscheme = { "tokyonight", "habamax" } },
--   checker = {
--     enabled = true, -- check for plugin updates periodically
--     notify = false, -- notify on update
--   }, -- automatically check for plugin updates
--   performance = {
--     rtp = {
--       -- disable some rtp plugins
--       disabled_plugins = {
--         "gzip",
--         -- "matchit",
--         -- "matchparen",
--         -- "netrwPlugin",
--         "tarPlugin",
--         "tohtml",
--         "tutor",
--         "zipPlugin",
--       },
--     },
--   },
-- })
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Keep largefile plugin active but use the new cutoff
vim.g.largefile_enabled = 0
require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { "ibhagwan/fzf-lua", enabled = false },
    {
      "windwp/nvim-ts-autotag",
      opts = {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Optional: disable closing on trailing </
        },
        per_filetype = {
          tsx = { enable_close = true },
          jsx = { enable_close = true },
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.autotag = { enable = true }
        opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
          "html",
          "javascript",
          "typescript",
          "tsx",
        })
      end,
    },
    -- { "nvim-telescope/telescope.nvim", enabled = true },

    -- {
    --   "hrsh7th/nvim-cmp",
    --   optional = true,
    --   dependencies = { "tzachar/cmp-tabnine" },
    --   ---@param opts cmp.ConfigSchema
    --   opts = function(_, opts)
    --     table.insert(opts.sources, 1, {
    --       name = "cmp_tabnine",
    --       group_index = 1,
    --       priority = 100,
    --     })

    --     opts.formatting.format = LazyVim.inject.args(opts.formatting.format, function(entry, item)
    --       -- Hide percentage in the menu
    --       if entry.source.name == "cmp_tabnine" then
    --         item.menu = ""
    --       end
    --     end)
    --   end,
    -- },
    -- { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
    { import = "lazyvim.plugins.extras.ai.tabnine" },
    { import = "lazyvim.plugins.extras.lang.go" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin-frappe", "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
