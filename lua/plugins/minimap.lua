return {
  "echasnovski/mini.map",
  event = "VeryLazy",
  opts = function()
    local mini_map = require("mini.map")
    return {
      integrations = {
        mini_map.gen_integration.builtin_search(),
        mini_map.gen_integration.diagnostic(),
        mini_map.gen_integration.diff(),
      },
      symbols = {
        encode = mini_map.gen_encode_symbols.dot("4x2"),
      },
      window = {
        show_integration_count = false,
      },
    }
  end,
  config = function(_, opts)
    local mini_map = require("mini.map")
    mini_map.setup(opts)
    vim.defer_fn(function()
      mini_map.open()
    end, 100) -- slight delay to ensure UI is ready
  end,
}
