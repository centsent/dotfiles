(fn get-lsp []
  (local bufnr (vim.api.nvim_get_current_buf))
  (local clients (vim.lsp.get_clients {: bufnr}))

  (fn get-lsp-client-name []
    (local names {})
    (each [_ client (pairs clients)]
      (when (not (vim.tbl_contains names client.name))
        (tset names (+ (length names) 1) client.name)))
    (table.concat names ", "))

  (if (next clients)
      (get-lsp-client-name)
      ;; No active lsp client
      "No Active LSP"))

;; LSP client name component
(local lsp {1 get-lsp})
;; Buffer formatter name component
(fn get-formatters []
  (local formatters ((. (require :conform) :list_formatters_for_buffer)))
  (if (not= nil formatters)
      (table.concat formatters ",") ""))

(local formatter {1 get-formatters})

;; Buffer linter name component
(local linter
       {1 #((. (require :me.util) :get-linter-name))
        :cond (fn []
                ((. (require :me.util) :is-loaded) :nvim-lint))})

;; A gap between components
(local gap ["%="])

(local sections {:lualine_c [gap lsp formatter linter]})

(local winbar {:lualine_c [{1 #((. (require :nvim-navic) :get_location))
                            :cond #(and (. package.loaded :nvim-navic)
                                        ((. (require :nvim-navic) :is_available)))}]
               :lualine_x [{1 :filename :path 1}]})

;; A blazing fast and easy to configure neovim statusline plugin written in pure lua.
{1 :nvim-lualine/lualine.nvim :opts {: sections : winbar} :event :VeryLazy}
