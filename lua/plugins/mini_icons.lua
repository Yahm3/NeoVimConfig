return {
  {
    "nvim-mini/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
      -- This line tells Neovim to use mini.icons whenever a plugin
      -- asks for nvim-web-devicons.
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },
}
