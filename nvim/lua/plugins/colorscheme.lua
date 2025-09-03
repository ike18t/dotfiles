-- Using Lazy
return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "cool",
        transparent = true,
      })
      -- Enable theme
      require("onedark").load()
    end,
  },
}
