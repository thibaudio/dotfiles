local home = vim.fn.expand("~/Nextcloud/org")
local templates = home .. '/' .. 'templates'
require("telekasten").setup({
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
  image_subdir = "img",
})
