{;; Faster LuaLS setup for Neovim
 1 :folke/lazydev.nvim
 :ft :lua
 :cmd :LazyDev
 :opts {:library [{:path "${3rd}/luv/library" :words ["vim%.uv"]}
                  {:path :snacks.nvim :words [:Snacks]}
                  {:path :lazy.nvim :words [:LazyPluginSpec]}]}}
