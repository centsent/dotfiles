{1 :neovim/nvim-lspconfig
 :dependencies [{;; Tools to help create flutter apps in neovim using the native lsp
                 1 :akinsho/flutter-tools.nvim
                 :config true
                 :event [:BufReadPost :BufNewFile]
                 :ft [:dart]}]
 :opts {:servers {:dartls {}}}}

