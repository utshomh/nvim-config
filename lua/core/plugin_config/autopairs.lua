local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

autopairs.setup({})

local cmp_ok, cmp = pcall(require, "cmp")
local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if cmp_ok and cmp_autopairs_ok then
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
