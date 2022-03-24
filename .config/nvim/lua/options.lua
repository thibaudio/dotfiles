local options = {
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noinsert", "noselect" }, -- mostly just for cmp
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

