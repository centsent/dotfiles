(fn setup-tsserver [_ opts]
  (local typescript (require :typescript))
  (typescript.setup {:server opts})
  (local augroup (vim.api.nvim_create_augroup :TypescriptOrganizeImport {}))
  (vim.api.nvim_create_autocmd :BufWritePre
                               {:group augroup
                                :pattern [:*.ts :*.tsx :*.js :*.jsx]
                                :callback (fn []
                                            (typescript.actions.addMissingImports {:sync true})
                                            (typescript.actions.fixAll {:sync true})
                                            (typescript.actions.organizeImports {:sync true}))}))

{1 :neovim/nvim-lspconfig
 :dependencies [;; A Lua plugin written in TypeScript to write TypeScript (Lua optional).
                :jose-elias-alvarez/typescript.nvim]
 :opts {:servers {:tsserver {}} :setup {:tsserver setup-tsserver}}}

