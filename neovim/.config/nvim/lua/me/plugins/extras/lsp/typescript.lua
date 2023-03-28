-- :fennel:1679922032
local function setup_tsserver(_, opts)
  local typescript = require("typescript")
  return typescript.setup({server = opts})
end
return {dependencies = {"jose-elias-alvarez/typescript.nvim"}, opts = {tsserver = {}, setup = {tsserver = setup_tsserver}}, "neovim/nvim-lspconfig"}