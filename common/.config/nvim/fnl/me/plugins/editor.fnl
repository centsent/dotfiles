[;; A file explorer tree for neovim written in lua
 {1 :nvim-tree/nvim-tree.lua
  :keys [{1 :<leader>f 2 ":NvimTreeToggle<cr>" :desc "Explorer NvimTree"}]
  :opts {:disable_netrw true}}
 ;; Smart and powerful comment plugin for neovim
 {1 :numToStr/Comment.nvim
  :config true
  :lazy true
  :event [:BufReadPost :BufNewFile]}
 ;; Treesitter based structural search and replace plugin for Neovim
 {1 :cshuaimin/ssr.nvim
  :keys [{1 :<leader>sr
          2 #((. (require :ssr) :open))
          :desc "Replace in files (ssr.nvim)"}]}
 ;; EditorConfig plugin for Neovim
 {1 :gpanders/editorconfig.nvim :event [:BufNewFile :BufReadPost]}
 ;; A super powerful autopair plugin for Neovim that supports multiple characters
 {1 :windwp/nvim-autopairs :config true :event [:BufNewFile :BufReadPost]}
 ;; Add/change/delete surrounding delimiter pairs with ease.
 {1 :kylechui/nvim-surround :config true :event [:BufNewFile :BufReadPost]}
 ;; The fastest Neovim colorizer.
 {1 :norcalli/nvim-colorizer.lua :opts {} :event [:BufNewFile :BufReadPost]}
 ;; Navigate your code with search labels enhanced character motions and Treesitter integration
 {1 :folke/flash.nvim
  :opts {:search {:mode :fuzzy} :mode {:char {:enabled false}}}
  :keys [{1 :s 2 #((. (require :flash) :jump)) :mode [:n :x :o] :desc :Flash}
         {1 :S
          2 #((. (require :flash) :treesitter))
          :mode [:n :o :x]
          :desc "Flash Treesitter"}
         {1 :r 2 #((. (require :flash) :remote)) :mode :o :desc "Remote Flash"}
         {1 :R
          2 #((. (require :flash) :treesitter_search))
          :mode [:o :x]
          :desc "Flash Treesitter Search"}]}
 ;; A markdown preview directly in your neovim
 {1 :ellisonleao/glow.nvim
  :config true
  :cmd [:Glow]
  :keys [{1 :<leader>mp 2 ":Glow<cr>" :desc "Preview Markdown in Glow"}]}]

