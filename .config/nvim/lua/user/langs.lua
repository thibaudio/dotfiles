local servers = {
  rust = {'rust_analyzer', 'codelldb'},
	terraform = {'terraformls', ''},
	python = {'jedi_language_server', 'python'},
	lua = {'lua_ls', ''},
	gdscript = {'', ''},
	godot_resource = {'', ''},
	vim = {'', ''},
	bash = {'', 'bash'},
  markdown = {'marksman', ''}
}

local ts_servers = {}
local lsp_servers = {}
local dap_servers = {}

for k,v in pairs(servers) do
  ts_servers[#ts_servers+1]=k
	if v[1] ~= '' then
		lsp_servers[#lsp_servers+1] = v[1]
	end
	if v[2] ~= '' then
		dap_servers[#dap_servers+1] = v[2]
	end
end

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed(lsp_servers)

lsp.setup()

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- Copilot
require('copilot').setup({
  suggestion = {enabled = false},
  panel = {enabled = false},
})

-- Enable tab completion
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  source = {
    {name = 'copilot'},
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  }
})

-- DAP
require("mason-nvim-dap").setup({
	ensure_installed = dap_servers,
  handlers = {},
})

local dap, dapui = require "dap", require "dapui"
dapui.setup {} -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end


-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = ts_servers,

  highlight = { 
    enable = true,
    additional_vim_regex_highlighting = false, 
  },
  auto_install = true,
}

