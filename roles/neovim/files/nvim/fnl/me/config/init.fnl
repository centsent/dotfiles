(local M {})

(set M.icons {:diagnostics {:Error " "
                            :Warn " "
                            :Hint " "
                            :Info " "}
              :git {:added " "
                    :modified " "
                    :removed " "
                    :branch ""}
              :kinds {:Array " "
                      :Boolean " "
                      :Class " "
                      :Color " "
                      :Constant " "
                      :Constructor " "
                      :Copilot " "
                      :Enum " "
                      :EnumMember " "
                      :Event " "
                      :Field " "
                      :File " "
                      :Folder " "
                      :Function " "
                      :Interface " "
                      :Key " "
                      :Keyword " "
                      :Method " "
                      :Module " "
                      :Namespace " "
                      :Null "ﳠ "
                      :Number " "
                      :Object " "
                      :Operator " "
                      :Package " "
                      :Property " "
                      :Reference " "
                      :Snippet " "
                      :String " "
                      :Struct " "
                      :Text " "
                      :TypeParameter " "
                      :Unit " "
                      :Value " "
                      :Variable " "}})

(set M.autoformat true)

(fn M.toggle-autoformat []
  ;; Toggle autoformatting on save
  (set M.autoformat (not M.autoformat))
  (local lazy-util (require :lazy.core.util))
  (if M.autoformat
      (lazy-util.info "Enabled format on save" {:title :LspFormat})
      (lazy-util.warn "Disabled format on save" {:title :LspFormat})))

(fn set-colorscheme [scheme]
  (vim.cmd (.. "colorscheme " scheme)))

(fn load-configs []
  (local util (require :me.util))
  (local config-prefix :me.config.)
  (local mods [:options :autocmds :keymaps])
  (each [_ mod (ipairs mods)]
    (util.load (.. config-prefix mod))))

(fn M.setup [_opts]
  (set-colorscheme :tokyonight)
  (load-configs))

M

