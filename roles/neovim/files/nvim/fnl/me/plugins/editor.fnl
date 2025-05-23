[;; Smart and powerful comment plugin for neovim
 {1 :numToStr/Comment.nvim
  :config true
  :lazy true
  :event [:BufReadPost :BufNewFile]}
 ;; EditorConfig plugin for Neovim
 {1 :gpanders/editorconfig.nvim :event [:BufNewFile :BufReadPost]}
 ;; A super powerful autopair plugin for Neovim that supports multiple characters
 {1 :windwp/nvim-autopairs :config true :event [:BufNewFile :BufReadPost]}
 ;; Add/change/delete surrounding delimiter pairs with ease.
 {1 :kylechui/nvim-surround :config true :event [:BufNewFile :BufReadPost]}
 ;; The fastest Neovim colorizer.
 {1 :norcalli/nvim-colorizer.lua
  :event [:BufNewFile :BufReadPost]
  :config (fn []
            ((. (require :colorizer) :setup)))}
 ;; Navigate your code with search labels enhanced character motions and Treesitter integration
 {1 :folke/flash.nvim
  :event [:VeryLazy]
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
  :keys [{1 :<leader>mp 2 ":Glow<cr>" :desc "Preview Markdown in Glow"}]}
 ;; Neovim plugin for splitting/joining blocks of code
 {1 :Wansmer/treesj
  :keys [:<space>m :<space>j :<space>s]
  :dependencies [:nvim-treesitter/nvim-treesitter]
  :config true}
 ;; Create key bindings that stick
 {1 :folke/which-key.nvim
  :event [:VeryLazy]
  :opts {:plugins {:spelling true}
         :defaults [{1 :t :mode [:n :v] :group :Tabs}
                    {1 :f :group :Fzf :mode [:n :v]}]}
  :config true}
 {1 :aznhe21/actions-preview.nvim
  :config (fn []
            (local actions-preview (require :actions-preview))
            (vim.keymap.set [:v :n] :ga actions-preview.code_actions))}
 ;; Establish good command workflow and quit bad habit
 {1 :m4xshen/hardtime.nvim
  :dependencies [:MunifTanjim/nui.nvim :nvim-lua/plenary.nvim]
  :opts {}}
 ;; Smooth cursor
 {1 :gen740/SmoothCursor.nvim :config true :opts {:fancy {:enable true}}}
 ;; Peek lines just when you intend
 {1 :nacro90/numb.nvim :config true :event [:BufReadPost]}
 ;; search/replace in multiple files
 {1 :MagicDuck/grug-far.nvim
  :opts {:headerMaxWidth 80}
  :cmd :GrugFar
  :keys [{1 :<leader>sr
          2 (fn []
              (local grug (require :grug-far))
              (local ext (and (= vim.bo.buftype "") (vim.fn.expand "%:e")))
              (local files-filter (if (and ext (not= ext ""))
                                      (.. "*." ext)
                                      nil))
              (grug.open {:transient true
                          :prefills {:filesFilter files-filter}}))
          :mode [:n :v]
          :desc "Search and Replace in multiple files"}]}]
