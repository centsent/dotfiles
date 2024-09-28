(fn set-local-keymap [bufnr]
  (local local-keymaps
         [{:mode :n
           :lhs :gd
           :rhs :<Cmd>TSToolsGoToSourceDefinition<CR>
           :opts {:buffer bufnr :desc "Source Definition"}}
          {:mode :n
           :lhs :<leader>i
           :rhs :<Cmd>TSToolsAddMissingImports<CR>
           :opts {:buffer bufnr :desc "Add Missing Imports"}}
          {:mode :n
           :lhs :<leader>o
           :rhs :<Cmd>TSToolsOrganizeImports<CR>
           :opts {:buffer bufnr :desc "Organize Imports"}}
          {:mode :n
           :lhs :<leader>r
           :rhs :<Cmd>TSToolsRemoveUnused<CR>
           :opts {:buffer bufnr :desc "Remove Unused Variables"}}
          {:mode :n
           :lhs :<leader>F
           :rhs :<Cmd>TSToolsFixAll<CR>
           :opts {:buffer bufnr :desc "Fix All"}}])
  (each [_ keymap (pairs local-keymaps)]
    (vim.keymap.set keymap.mode keymap.lhs keymap.rhs keymap.opts)))

(fn on-attach [client bufnr]
  (set client.server_capabilities.documentFormattingProvider false)
  (set client.server_capabilities.documentRangeFormattingProvider false)
  (set-local-keymap bufnr))

{;; TypeScript integration NeoVim deserves
 1 :pmizio/typescript-tools.nvim
 :dependencies [:nvim-lua/plenary.nvim :neovim/nvim-lspconfig]
 :opts {:filetypes [:javascript
                    :javascriptreact
                    :typescript
                    :typescriptreact
                    :vue]
        :on_attach on-attach
        :settings {:tsserver_file_preferences {:importModuleSpecifiePreference :non-relative
                                               :includeInlayParameterNameHints :all
                                               :includeInlayParameterNameHintsWhenArgumentMatchesName false
                                               :includeInlayFunctionParameterTypeHints true
                                               :includeInlayVariableTypeHints true
                                               :includeInlayPropertyDeclarationTypeHints true
                                               :includeInlayFunctionLikeReturnTypeHints true
                                               :includeInlayEnumMemberValueHints true}
                   :tsserver_plugins ["@vue/typescript-plugin"]}
        :code_lens :all}}

