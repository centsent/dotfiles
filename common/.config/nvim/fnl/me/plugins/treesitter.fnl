(fn create-textobjects []
  "Create textobjects"
  {:select {:enable true
            :keymaps {:ia "@attribute.inner"
                      :iA "@attribute.outer"
                      :ic "@conditional.inner"
                      :iC "@conditional.outer"
                      :if "@function.inner"
                      :iF "@function.outer"
                      :il "@loop.inner"
                      :iL "@loop.outer"
                      :ip "@parameter.inner"
                      :iP "@parameter.outer"}}})

(fn create-opts [textobjects]
  "Create treesitter configurations"
  {:ensure_installed :all
   :highlight {:enable true :additional_vim_regex_highlighting false}
   :rainbow {:enable true}
   :indent {:enable true}
   :autotag {:enable true}
   : textobjects})

(fn get-dependencies []
  "Get treesitter dependencies"
  [;; Use treesitter to autoclose and autorename html tag
   :windwp/nvim-ts-autotag
   ;; Rainbow parentheses for neovim using tree-sitter
   :p00f/nvim-ts-rainbow
   ;; Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
   :JoosepAlviste/nvim-ts-context-commentstring
   ;; Show code context
   :nvim-treesitter/nvim-treesitter-context
   ;; Syntax aware text-objects select move swap and peek support.
   :nvim-treesitter/nvim-treesitter-textobjects])

(fn config [_ settings]
  "Configure treesitter"
  (local ts (require :nvim-treesitter.configs))
  (ts.setup settings))

(fn setup-treesitter [textobjects]
  "Nvim Treesitter configurations and abstraction layer"
  (let [opts (create-opts textobjects)
        dependencies (get-dependencies)]
    {1 :nvim-treesitter/nvim-treesitter
     :build ":TSUpdate"
     :event [:BufReadPost :BufNewFile]
     : opts
     : dependencies
     : config}))

(setup-treesitter (create-textobjects))

