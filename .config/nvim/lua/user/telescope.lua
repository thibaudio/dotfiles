local actions = require("telescope.actions")
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_previous,
				["<C-k>"] = actions.move_selection_next
			}
		}
	}
}
require("telescope").load_extension "file_browser"
