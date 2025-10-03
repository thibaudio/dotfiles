return {
  --- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdscript",
        "godot_resource",
        "gdshader",
        "odin",
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
  {
    "teatek/gdscript-extended-lsp.nvim",
    opts = {},
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
