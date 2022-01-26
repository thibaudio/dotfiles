-- doom_userplugins - Doom nvim custom plugins
--
-- This file contains all the custom plugins that are not in Doom nvim but that
-- the user requires. All the available fields can be found here
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
--
-- By example, for including a plugin with a dependency on telescope:
-- M.plugins {
--   {
--     'user/repository',
--     requires = { 'nvim-lua/telescope.nvim' },
--   },
-- }

local M = {}

M.source = debug.getinfo(1, "S").source:sub(2)

M.plugins = {
	{
		'renerocksai/telekasten.nvim',
		requires = { 'nvim-lua/telescope.nvim' },
		config = function()
			local home = vim.fn.expand("~/Nextcloud/org")
			local templates = home .. '/' .. 'templates'
			require('telekasten').setup({
				home = home,
				auto_set_filetype = true,
				dailies      = home .. '/' .. 'dailies',
				weeklies     = home .. '/' .. 'weeklies',
				templates    = templates,
				extension    = ".md",
				follow_creates_nonexisting = true,
    		dailies_create_nonexisting = true,
    		weeklies_create_nonexisting = true,
    		template_new_note = templates .. '/' .. 'note.md',
    		template_new_daily = templates .. '/' .. 'daily.md',
    		template_new_weekly = templates .. '/' .. 'weekly.md',
			})
			end
	},
}

return M

-- vim: sw=2 sts=2 ts=2 noexpandtab
