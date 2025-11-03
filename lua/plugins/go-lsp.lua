return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = false, -- This prevents parameter placeholders
              completionDocumentation = false,
              completeUnimported = true,
              deepCompletion = true,
              matcher = "fuzzy",
              -- Disable snippet-like completions
              experimentalPostfixCompletions = false,
            },
          },
        },
      },
    },
  },
}
