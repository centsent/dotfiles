(fn init-notify []
  (local util (require :me.util))
  (when (not (util.has :noice.nvim))
    (util.on-very-lazy #(set vim.notify (require :notify)))))

[;; A fancy configurable notification manager for NeoVim
 {1 :rcarriga/nvim-notify
  :opts {:timeout 3000
         :max_width #(math.floor (* vim.o.columns 0.75))
         :max_height #(math.floor (* vim.o.lines 0.75))}
  :init init-notify
  :keys [{1 :<leader>n
          2 #((. (require :notify) :dismiss) {:silent true :pending true})
          :desc "Dismiss all notifications"}]}
 ;; Indent guides for Neovim
 {1 :lukas-reineke/indent-blankline.nvim
  :main :ibl
  :opts {}
  :event [:BufReadPost :BufNewFile]}
 ;; Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                          :vim.lsp.util.stylize_markdown true
                          :cmp.entry.get_documentation true}}
         :presets {:command_palette true
                   :long_message_to_split true
                   :bottom_search true}}}
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
