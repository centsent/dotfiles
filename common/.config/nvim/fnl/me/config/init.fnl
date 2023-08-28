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

(fn set-colorscheme []
  (local colorscheme-list [:tokyonight
                           :kanagawa
                           :nightfox
                           :carbonfox
                           :terafox
                           :duskfox
                           :nordfox
                           :catppuccin
                           :edge
                           :material
                           :rose-pine
                           :minimal
                           :melange
                           :minimal-base16
                           :sonokai
                           :gruvbox
                           :gruvbox-material
                           :OceanicNext])
  (local index (math.random (length colorscheme-list)))
  (local colorscheme (. colorscheme-list index))
  (vim.cmd (.. "colorscheme " colorscheme)))

(fn load-configs []
  (local util (require :me.util))
  (local config-prefix :me.config.)
  (local mods [:options :autocmds :keymaps])
  (each [_ mod (ipairs mods)]
    (util.load (.. config-prefix mod))))

(fn M.setup [_opts]
  (local util (require :me.util))
  (math.randomseed (os.time))
  (local sleep (* 1000 60 15))
  (util.start-timer sleep set-colorscheme)
  (load-configs))

M

