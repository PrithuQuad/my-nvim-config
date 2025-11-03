return {
  {
    "echasnovski/mini.files",
    version = false,
    dependencies = { "edluffy/hologram.nvim" },
    config = function()
      -- 1. Configure Hologram for inline graphics
      require("hologram").setup({
        auto_display = false,
        providers = { kitty = true, iterm = true },
      })

      -- 2. Basic mini.files setup
      require("mini.files").setup({
        -- your mini.files options here, e.g.:
        --   view = "details", width = 30, mappings = { ... }
      })

      local mini_files = require("mini.files")
      local holo = require("hologram")

      -- Yank current file’s content into the system clipboard
      local function yank_file_content()
        local entry = mini_files.get_fs_entry()
        if not entry or entry.is_directory then
          return
        end
        vim.system({ "xclip", "-selection", "clipboard", "-in", entry.path }, {}, function() end)
      end

      -- Paste clipboard text into a newly created file
      local function paste_content_as_new_file()
        local entry = mini_files.get_fs_entry()
        if not entry then
          return
        end

        local name = vim.fn.input("New file name: ")
        if name == "" then
          return
        end

        local dir = vim.fn.fnamemodify(entry.path, ":p:h")
        local target = dir .. "/" .. name
        local content = vim.fn.getreg("+")
        local fd = io.open(target, "w")
        if fd then
          fd:write(content)
          fd:close()
          mini_files.refresh()
        end
      end

      -- Show image (PNG/JPG/GIF or SVG) in the preview pane
      local function show_image_in_preview(data)
        local entry = data.fs_entry
        if not entry or entry.is_directory then
          return
        end

        local ext = vim.fn.fnamemodify(entry.path, ":e"):lower()
        local image_exts = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "svg" }
        if not vim.tbl_contains(image_exts, ext) then
          return
        end

        local buf = data.buf_id
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        -- clear previous content
        vim.api.nvim_buf_set_option(buf, "modifiable", true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

        -- try Hologram
        if ext == "svg" then
          -- convert SVG → PNG
          local cmd = {
            "rsvg-convert",
            "--format=png",
            "--width=" .. vim.o.columns,
            entry.path,
          }
          holo.display_image(buf, cmd)
        else
          holo.display_image(buf)
        end

        -- fallback to viu if no output
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          if #lines == 0 then
            vim.system({ "viu", "-w", tostring(vim.o.columns), entry.path }, { text = true }, function(res)
              vim.schedule(function()
                if res.code == 0 and vim.api.nvim_buf_is_valid(buf) then
                  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(res.stdout or "", "\n"))
                end
              end)
            end)
          end
        end)

        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "image_preview")
      end

      -- Autocommands for keymaps + preview trigger
      local aug = vim.api.nvim_create_augroup("MiniFilesExtras", { clear = true })

      -- Yank/Paste mappings in the file list buffer
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        group = aug,
        callback = function(args)
          local buf = args.data.buf_id
          vim.keymap.set("n", "yy", yank_file_content, { buffer = buf, desc = "Yank file contents" })
          vim.keymap.set("n", "pp", paste_content_as_new_file, { buffer = buf, desc = "Paste clipboard as new file" })
        end,
      })

      -- Image preview on each window update (preview pane only)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        group = aug,
        callback = function(args)
          if args.data.kind == "preview" then
            show_image_in_preview(args.data)
          end
        end,
      })
    end,
  },
}
