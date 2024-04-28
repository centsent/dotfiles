(fn get-luals-settings []
  {:settings {:Lua {:completion {:callSnippet :Replace}
                    :diagnostics {:globals [:vim]}
                    :workspace {:checkThirdParty false}}}})

{1 :neovim/nvim-lspconfig :opts {:servers {:lua_ls (get-luals-settings)}}}

