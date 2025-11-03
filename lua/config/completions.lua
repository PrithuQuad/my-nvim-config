return {
  {
    "saghen/blink.cmp",
    optional = true,

    dependencies = { "tzachar/cmp-tabnine", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "cmp_tabnine" },
        providers = {
          cmp_tabnine = {
            kind = "TabNine",
            score_offset = 100,
            async = true,
          },
        },
      },
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      -- Add key mappings for Tab and Shift+Tab navigation
    },
  },
}
