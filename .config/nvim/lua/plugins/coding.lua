return {
  --- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    --- Copied From https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
    --- To force zig as compiler
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = { "zig" }
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      ensure_installed = {
        "gdscript",
        "godot_resource",
        "gdshader",
      },
    },
  },

  --- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
      },
    },
  },
}
