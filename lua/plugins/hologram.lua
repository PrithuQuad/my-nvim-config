-- File: ~/.config/nvim/lua/plugins/hologram.lua
return {
  "edluffy/hologram.nvim",
  opts = {
    auto_display = false,
    providers = {
      kitty = true,
      iterm = true,
    },
  },
  config = function(_, opts)
    local holo = require("hologram")
    holo.setup(opts)

    -- For PNG, JPG, GIF, etc.
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.bmp", "*.webp" },
      callback = function(args)
        -- display_image(bufnr) uses args.buf if called in BufReadPost
        holo.display_image(args.buf)
      end,
    })

    -- For SVG, convert to PNG on the fly
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*.svg",
      callback = function(args)
        -- build a converter command
        local cmd = {
          "rsvg-convert",
          "--format=png",
          "--width=" .. vim.o.columns,
          args.file,
        }
        -- pass it to display_image; Hologram will shell out
        holo.display_image(args.buf, cmd)
      end,
    })
  end,
}
