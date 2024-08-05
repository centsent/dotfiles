(fn get-fzf-keymaps []
  (local fzf (require :fzf-lua))
  [{1 :ff 2 fzf.files :desc "find or fd on a path"}
   {1 :fg 2 fzf.live_grep_resume :desc "live grep current project"}
   {1 :fG 2 fzf.grep_last :desc "live grep continue last search"}
   {1 :fb 2 fzf.buffers :desc "Fzf buffers"}
   {1 :fd 2 fzf.lsp_document_symbols :desc "Fzf lsp document symbols"}
   {1 :fm 2 fzf.keymaps :desc "Fzf keymaps"}
   {1 :fr 2 fzf.lsp_references :desc "Fzf lsp references"}])

(fn setup []
  (local fzf (require :fzf-lua))
  (fzf.setup))

[;; Improved fzf.vim written in lua
 {1 :ibhagwan/fzf-lua
  :dependencies [:nvim-tree/nvim-web-devicons]
  :config setup
  :keys get-fzf-keymaps}]

