return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = { transparent_background = true },
  configs = function(_, opts)
    require('catpuccin.config').setup(opts)
  end
}
