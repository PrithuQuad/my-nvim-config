return {
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tagsV
        enable_close_on_slash = true, -- Optional: disable closing on trailing </
      },
      per_filetype = {
        tsx = {
          enable_close = true,
          enable_rename = true, -- Auto rename pairs of tagsV
          enable_close_on_slash = true, -- Optional: disable closing on trailing </
        },
        jsx = {
          enable_close = true,
          enable_rename = true, -- Auto rename pairs of tagsV
          enable_close_on_slash = true, -- Optional: disable closing on trailing </
        },
      },
    },
  },
}
