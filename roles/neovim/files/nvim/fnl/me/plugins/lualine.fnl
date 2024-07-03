(local config (require :me.config))
(local lsp-signs config.icons.diagnostics)
(local git-icons config.icons.git)
(local bold :bold)
(local colors {:bg "#0f1624"
               :fg "#e0e0e0"
               :lightblue "#4da8da"
               :lime "#9ece6a"
               :yellow "#ECBE7B"
               :cyan "#008080"
               :green "#6e9462"
               :orange "#f2c94c"
               :magenta "#c678dd"
               :blue "#248cbc"
               :red "#ec5f67"
               :lavender "#bb9af7"
               :rose "#f7768e"
               :white "#ffffff"})

(local mode-colors {:n colors.lightblue
                    :v colors.lavender
                    :x colors.rose
                    :i colors.lime
                    :o colors.cyan
                    :R colors.rose})

(fn create-component [type color fmt]
  {:1 type :color {:bg colors.bg :fg color :gui bold} : fmt})

;; File format component
(local fileformat (create-component :fileformat colors.green nil))
;; File encoding component
(local encoding (create-component :encoding colors.green string.upper))

;; File name component
(local filename {1 :filename :color {:fg colors.blue :gui bold}})
;; File type component
(local filetype {1 :filetype :icon_only true})
;; File size component
(local filesize {1 :filesize :color {:fg colors.white}})
;; Cursor progress component
(local progress {1 :progress :color {:bg colors.bg :fg colors.fg :gui bold}})
;; Cursor location component
(local location {1 :location :color {:bg colors.bg :fg colors.fg :gui bold}})
;; Git branch component
(local branch
       {1 :branch
        :icon git-icons.branch
        :color {:bg colors.bg :fg colors.magenta :gui bold}})

(local diff-symbols {:added git-icons.added
                     :modified git-icons.modified
                     :removed git-icons.removed})

(local diff-color {:added {:fg colors.green}
                   :modified {:fg colors.orange}
                   :removed {:fg colors.red}})

;; Git diff component
(local diff {1 :diff
             :symbols diff-symbols
             :diff_color diff-color
             :color {:bg colors.bg}})

(local diagnostics-symbols {:error lsp-signs.Error
                            :warn lsp-signs.Warn
                            :info lsp-signs.Info})

(local diagnostics-color
       {:color_error {:fg colors.red}
        :color_warn {:fg colors.yellow}
        :color_info {:fg colors.cyan}})

;; LSP diagnostics component
(local diagnostics {1 :diagnostics
                    :sources [:nvim_diagnostic]
                    :symbols diagnostics-symbols
                    :diagnostics_color diagnostics-color
                    :color {:bg colors.bg}})

(fn get-lsp []
  (local bufnr (vim.api.nvim_get_current_buf))
  (local clients (vim.lsp.get_active_clients {: bufnr}))

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
(local lsp {1 get-lsp :color {:fg colors.white :gui bold}})
;; Buffer formatter name component
(fn get-formatters []
  (local formatters ((. (require :conform) :list_formatters_for_buffer)))
  (if (not= nil formatters)
      (table.concat formatters ",") ""))

(local formatter {1 get-formatters :color {:fg colors.green}})

;; Buffer linter name component
(local linter
       {1 #((. (require :me.util) :get-linter-name))
        :color {:fg colors.cyan}
        :cond (fn []
                ((. (require :me.util) :is-loaded) :nvim-lint))})

;; A gap between components
(local gap ["%="])

(fn get-mode-color []
  (local fg (or (. mode-colors (vim.fn.mode)) colors.rose))
  {: fg :bg colors.bg})

;; Vim mode component
(local mode {1 :mode :color get-mode-color})

(fn get-current-time []
  (string.format "%s" (os.date "%H:%M:%S")))

;; Current time component
(local time {1 get-current-time :color {:fg colors.green :bg colors.bg}})

(local components {: encoding
                   : fileformat
                   : filename
                   : filetype
                   : filesize
                   : progress
                   : location
                   : branch
                   : diff
                   : diagnostics
                   : lsp
                   : formatter
                   : linter
                   : gap
                   : mode
                   : time})

(local sections {:lualine_a [components.mode]
                 :lualine_b [components.branch
                             components.diff
                             components.diagnostics]
                 :lualine_c [components.filetype
                             components.filename
                             components.filesize
                             components.gap
                             components.lsp
                             components.formatter
                             components.linter]
                 :lualine_x [components.progress]
                 :lualine_y [components.location]
                 :lualine_z [components.encoding
                             components.fileformat
                             components.time]})

(local winbar {:lualine_c [{1 #((. (require :nvim-navic) :get_location))
                            :cond #(and (. package.loaded :nvim-navic)
                                        ((. (require :nvim-navic) :is_available)))}]
               :lualine_x [{1 :filename :path 1}]})

;; A blazing fast and easy to configure neovim statusline plugin written in pure lua.
{1 :nvim-lualine/lualine.nvim
 :opts {:options {:component_separators "" :section_separators ""}
        : sections
        : winbar}
 :event :VeryLazy}

