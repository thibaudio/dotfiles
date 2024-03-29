local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true,       -- shows a list of your marks on ' and `
		registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true,      -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true,      -- default bindings on <c-w>
			nav = true,          -- misc bindings to work with windows
			z = true,            -- bindings for folds, spelling and others prefixed with z
			g = true,            -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+",      -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>",   -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded",       -- none, single, double, shadow
		position = "bottom",      -- bottom, top
		margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },                                             -- min and max height of the columns
		width = { min = 20, max = 50 },                                             -- min and max width of the columns
		spacing = 3,                                                                -- spacing between columns
		align = "left",                                                             -- align columns left, center or right
	},
	ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                             -- show help message on the command line when the popup is visible
	triggers = "auto",                                                            -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n",     -- NORMAL mode
	prefix = "<leader>",
	buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true,  -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
	--  ["a"] = { "<cmd>Alpha<cr>", "Alpha" }, --- greeter, tb added
	--  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	--  ["w"] = { "<cmd>w!<CR>", "Save" },
	--  ["q"] = { "<cmd>q!<CR>", "Quit" },
			["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		g = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
		i = { "<cmd>lua vim.lsp.buf.implementation<cr>", "Go to implementation" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
		R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
		h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	n = {
		name = "+ Notes",
		n = { "<cmd> Telekasten new_note<cr>", "New" },
		f = { "<cmd> Telekasten find_notes<cr>", "Find note" },
		t = { "<cmd> Telekasten goto_today<cr>", "Today" },
		i = { "<cmd> Telekasten insert_link<cr>", "Insert link" },
		l = { "<cmd> Telekasten follow_link<cr>", "Follow link" },
		s = { "<cmd> Telekasten search_notes<cr>", "Search" },
		S = {
			"<cmd>lua require('telescope.builtin').live_grep{find_command=rg, search_dirs={'~/Nextcloud/4-Archives/org_archive'}}<cr>",
			"Search archives" },
		d = { "<cmd> Telekasten find_daily_notes<cr>", "Find dailies" },
		t = { "<cmd> Telekasten show_tags<cr>", "Tags" },
		b = { "<cmd> Telekasten show_backlinks<cr>", "Backlinks" },
		r = { "<cmd> Telekasten find_friends<cr>", "Find related notes" },
		p = { "<cmd> Telekasten paste_img_and_link<cr>", "Paste image" },
	},
	b = {
		name = "+ Buffers",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"List" },
		c = { "<cmd>bd<cr>", "Close current buffer" }
	},
	f = {
		name = "+ Files",
		f = { "<cmd>lua require('telescope.builtin').find_files{ hidden=true}<cr>", "Find files" },
		b = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Browser" },
		p = { "<cmd>Telescope git_files<cr>", "Find files in project" },
		s = { "<cmd>lua require('telescope.builtin').live_grep{find_command=rg}<cr>", "Search files" },
		S = {
			"<cmd>lua require('telescope.builtin').live_grep{find_command=rg, cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>",
			"Search files in project" },
		c = { "<cmd>Telescope find_files search_dirs={'~/.config/nvim'}<cr>", "Find config file" },
	},
	m = {
		name = "+ Make",
		r = { "<cmd>make run<cr>", "Run" },
		b = { "<cmd>make build<cr>", "Build" },
		t = { "<cmd>make test<cr>", "Tests" },
		f = { "<cmd>make fmt<cr>", "Format" },
	},
	d = {
		name = "Debug",
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
		U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)

local keymap_v = {
	name = "Debug",
	e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}
which_key.register(keymap_v, {
	mode = "v",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
