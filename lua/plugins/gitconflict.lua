return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPost",
  config = function()
    require("git-conflict").setup({
      default_mappings = false,
      default_commands = true,
      disable_diagnostics = false,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    })
  end,
  keys = {
    -- Navigation
    {
      "<leader>mn",
      "<Plug>(git-conflict-next-conflict)",
      desc = "Next conflict",
    },
    {
      "<leader>mp",
      "<Plug>(git-conflict-prev-conflict)",
      desc = "Previous conflict",
    },

    -- Resolution choices
    {
      "<leader>mo",
      "<Plug>(git-conflict-ours)",
      desc = "Choose ours (current)",
    },
    {
      "<leader>mt",
      "<Plug>(git-conflict-theirs)",
      desc = "Choose theirs (incoming)",
    },
    {
      "<leader>mb",
      "<Plug>(git-conflict-both)",
      desc = "Choose both",
    },
    {
      "<leader>m0",
      "<Plug>(git-conflict-none)",
      desc = "Choose none",
    },
    {
      "<leader>mx",
      "<Plug>(git-conflict-base)",
      desc = "Choose base",
    },

    -- Utility
    {
      "<leader>ml",
      "<cmd>GitConflictListQf<cr>",
      desc = "List conflicts in quickfix",
    },
    {
      "<leader>mr",
      "<cmd>GitConflictRefresh<cr>",
      desc = "Refresh conflict detection",
    },

    -- Git-style navigation (alternative to gitsigns)
    {
      "]x",
      "<Plug>(git-conflict-next-conflict)",
      desc = "Next conflict",
    },
    {
      "[x",
      "<Plug>(git-conflict-prev-conflict)",
      desc = "Previous conflict",
    },
  },
}
