(fn init-notify []
  (local util (require :me.util))
  (when (not (util.has :noice.nvim))
    (util.on-very-lazy #(set vim.notify (require :notify)))))

(fn init-ibl []
  ;; Multiple indent colors
  (local highlight [:RainbowRed
                    :RainbowYellow
                    :RainbowBlue
                    :RainbowOrange
                    :RainbowGreen
                    :RainbowViolet
                    :RainbowCyan])
  (local highlight-colors {:RainbowRed "#E06C75"
                           :RainbowYellow "#E5C07B"
                           :RainbowBlue "#61AFEF"
                           :RainbowOrange "#D19A66"
                           :RainbowGreen "#98C379"
                           :RainbowViolet "#C678DD"
                           :RainbowCyan "#56B6C2"})
  (local hooks (require :ibl.hooks))
  (local ibl (require :ibl))
  (hooks.register hooks.type.HIGHLIGHT_SETUP
                  (fn []
                    (each [key value (pairs highlight-colors)]
                      (vim.api.nvim_set_hl 0 key {:fg value}))))
  (ibl.setup {:indent {: highlight}}))

[;; A fancy configurable notification manager for NeoVim
 {1 :rcarriga/nvim-notify
  :opts {:timeout 3000
         :max_width #(math.floor (* vim.o.columns 0.75))
         :max_height #(math.floor (* vim.o.lines 0.75))}
  :init init-notify
  :keys [{1 :<leader>n
          2 #((. (require :notify) :dismiss) {:slient true :pending true})
          :desc "Dismiss all notifications"}]}
 ;; Indent guides for Neovim
 {1 :lukas-reineke/indent-blankline.nvim
  :main :ibl
  :init init-ibl
  :event [:BufReadPost :BufNewFile]}
 ;; Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                          :vim.lsp.util.stylize_markdown true
                          :cmp.entry.get_documentation true}
               :signature {:enabled false}}
         :presets {:command_palette true
                   :long_message_to_split true
                   :bottom_search true
                   :inc_rename true}}}
 ;; A snazzy bufferline for Neovim
 {1 :akinsho/bufferline.nvim
  :event :VeryLazy
  :opts {:options {:mode :tabs
                   :show_buffer_close_icons false
                   :show_close_icon false
                   :indicator {:style :underline}}}}
 ;; A pretty list for showing diagnostics references telescope results quickfix and location lists 
 ;; to help you solve all the trouble your code is causing.
 {1 :folke/trouble.nvim
  :opts {:win {:position :right}}
  :keys [{1 :gt
          2 ":Trouble diagnostics toggle<cr>"
          :desc "Open trouble list (Trouble.nvim)"}]}
 ;; lua `fork` of vim-web-devicons for neovim
 {1 :kyazdani42/nvim-web-devicons :lazy true}
 ;; UI Component Library for Neovim
 {1 :MunifTanjim/nui.nvim :lazy true}
 ;; Git integration for buffers
 {1 :lewis6991/gitsigns.nvim
  :event [:BufNewFile :BufReadPost]
  :opts {:current_line_blame true}}
 ;; Remove all background colors to make nvim transparent
 {1 :xiyaowong/transparent.nvim :opts {}}
 ;; A plugin for neovim that highlights cursor words and lines
 {1 :yamatsum/nvim-cursorline :opts {:cursorline {:timeout 500}}}]

