return {
  {
    "jparise/vim-graphql",
    ft = { "graphql", "javascript", "typescript" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "graphql", "javascript", "typescript" },
        highlight = { enable = true },
      })
    end,
  },
}
