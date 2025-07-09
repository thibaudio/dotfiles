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

  --- DAP
  {
    "mfussenegger/nvim-dap",

    --- From https://github.com/LazyVim/LazyVim/discussions/894
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        event = "BufReadPre",
      },
    },

    --- From https://gist.github.com/tsraveling/166d3f0970c6a7217754d0619471d320
    opts = function()
      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }
    end,
  },
}
