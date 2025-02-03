{1 :iabdelkareem/csharp.nvim
 :dependencies [:williamboman/mason.nvim
                :mfussenegger/nvim-dap
                :Tastyep/structlog.nvim]
 :config #(fn []
            ((require :mason) :setup)
            ((require :csharp) :setup))}

