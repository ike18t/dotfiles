return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "claude",
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
