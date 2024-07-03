(fn get-luals-settings []
  {:settings {:Lua {:completion {:callSnippet :Replace}
                    :codeLens {:enable true}
                    :workspace {:checkThirdParty false}}}})

{1 :neovim/nvim-lspconfig :opts {:servers {:lua_ls (get-luals-settings)}}}

