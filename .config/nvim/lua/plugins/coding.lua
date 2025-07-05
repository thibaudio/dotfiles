return {
  --- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = { "zig" }
    end,
  },
}
