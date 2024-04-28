{1 :neovim/nvim-lspconfig
 :dependencies [{;; A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.
                 1 :ray-x/go.nvim
                 :config true
                 :event [:BufReadPost :BufNewFile]
                 :ft [:go :gomod]
                 :build #((. (require :go.install) :update_all_sync))}]
 :opts {:servers {:gopls {}}}}

