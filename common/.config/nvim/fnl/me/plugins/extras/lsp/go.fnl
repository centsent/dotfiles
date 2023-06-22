(fn setup-autocmd []
  (local augroup (vim.api.nvim_create_augroup :GoFormat {}))
  (vim.api.nvim_create_autocmd :BufWritePost
                               {:group augroup
                                :pattern :*.go
                                :callback #((. (require :go.format) :goimport))}))

(fn setup []
  (setup-autocmd)
  ((. (require :go) :setup)))

{1 :neovim/nvim-lspconfig
 :dependencies [{;; A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.
                 1 :ray-x/go.nvim
                 :config setup
                 :event [:BufReadPost :BufNewFile]
                 :ft [:go :gomod]
                 :build #((. (require :go.install) :update_all_sync))}]
 :opts {:servers {:gopls {}}}}

