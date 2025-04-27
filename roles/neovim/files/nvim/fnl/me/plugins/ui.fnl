[{1 :folke/noice.nvim
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
 {1 :folke/snacks.nvim
  :opts {:bigfile {:enabled true}
         :explorer {:enabled true}
         :indent {:enabled true}
         :input {:enabled true}
         :notifier {:enabled true :timeout 3000}
         :picker {:enabled true}
         :scroll {:enabled true}
         :statuscolumn {:enabled true}
         :words {:enabled true}}
  :keys [;; Top Pickers & Explorer
         {1 :<space><space>
          2 #((. (require :snacks) :picker :smart))
          :desc "Smart Find Files"}
         {1 :<leader>e
          2 #((. (require :snacks) :explorer))
          :desc "File Explorer"}
         {1 :<leader>n
          2 #((. (require :snacks) :picker :notifications))
          :desc "Notification History"}
         ;; Terminal
         {1 :<leader>tt
          2 #((. (require :snacks) :terminal))
          :desc "Toggle Terminal"}
         {1 :<leader>tg
          2 #((. (require :snacks) :lazygit))
          :desc "Toggle Terminal"}
         ;; Find
         {1 :<leader>ff
          2 #((. (require :snacks) :picker :files))
          :desc "Find files"}
         {1 :<leader>fr
          2 #((. (require :snacks) :picker :recent))
          :desc "Recent files"}
         {1 :<leader>fp
          2 #((. (require :snacks) :picker :projects))
          :desc :Projects}
         ;; Grep
         {1 :<leader>sg 2 #((. (require :snacks) :picker :grep)) :desc :Grep}
         {1 :<leader>sw
          2 #((. (require :snacks) :picker :grep_word))
          :desc "Visual selection or word"}
         ;; Search
         {1 :<leader>sd
          2 #((. (require :snacks) :picker :diagnostics))
          :desc :Diagnostics}
         {1 :<leader>sj 2 #((. (require :snacks) :picker :jumps)) :desc :Jumps}
         ;; LSP
         {1 :gd
          2 #((. (require :snacks) :picker :lsp_definitions))
          :desc "Goto definition"}]}]
