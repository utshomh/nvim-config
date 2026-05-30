-- Telescope fuzzy finder configuration.

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        -- Make <Esc> close Telescope from insert mode instead of switching modes.
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
  },
})
