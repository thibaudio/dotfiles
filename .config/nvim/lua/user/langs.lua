local servers = {
  rust = 'rust_analyzer',
	terraform = 'terraformls',
	python = 'jedi_language_server',
	lua = 'lua_ls',
	gdscript = '',
	help = '',
	vim = '',
}

local ts_servers = {}
local lsp_servers = {}

for k,v in pairs(servers) do
  ts_servers[#ts_servers+1]=k
	if v ~= '' then
		lsp_servers[#lsp_servers+1] = v
	end
end

vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed(lsp_servers)

lsp.nvim_workspace()

lsp.setup()

require('nvim-treesitter.configs').setup {
  ensure_installed = ts_servers,

  highlight = { enable = true },
}


