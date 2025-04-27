[{1 :dstein64/vim-startuptime
  :cmd :StartupTime
  :config #(tset vim.g :startuptime_tries 10)}
 ;; Single tabpage interface for easily cycling through diffs for all modified files for any git rev
 {1 :sindrets/diffview.nvim
  :cmd {:DiffviewOpen :DiffviewClose :DiffviewToggleFiles :DiffviewFocusFiles}
  :config true
  :keys [{1 :<leader>gd 2 :<cmd>DiffviewOpen<cr> :desc :DiffView}]}
 ;; All the lua functions I don't want to write twice.
 {1 :nvim-lua/plenary.nvim :lazy true}
 ;; For my personal use only
 ;; The open source plugin for productivity metrics goals leaderboards and automatic time tracking.
 {1 :wakatime/vim-wakatime :event [:CursorMoved]}]
