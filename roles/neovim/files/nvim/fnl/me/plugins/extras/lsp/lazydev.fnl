{;; Faster LuaLS setup for Neovim
 1 :folke/lazydev.nvim
 :ft :lua
 :opts {:library [{:path :luvit-meta/library :words ["vim%.uv"]}
                  {:path :lazy.nvim :words [:LazyPluginSpec]}]}}

