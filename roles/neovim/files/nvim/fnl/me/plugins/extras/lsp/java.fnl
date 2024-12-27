{;; Painless Java in Neovim
 1 :nvim-java/nvim-java
 :dependencies [{1 :neovim/nvim-lspconfig
                 :opts {:servers {:jdtls {}}}
                 :setup (fn [_]
                          (local java (require :java))
                          (java.setup {}))}]
 :config true}
