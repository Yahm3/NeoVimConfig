return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*", -- or branch = "main", to use the latest commit
  opts = {
    win_opts = {
      row = vim.o.lines - vim.o.cmdheight, --- 1,
      --col = vim.o.columns - 1,
      col = 20,
      relative = "editor",
      anchor = "SE",
      width = 20,
      height = 2,
      border = "single",
      --title = "Screenkey",
      --title_pos = "center",
      style = "minimal",
      focusable = false,
      noautocmd = true,
    },
  },
}
