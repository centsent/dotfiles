(import-macros {: not-nil!} :macros)
(local M {})

(set M.autoformat true)

(fn M.toggle []
  ;; Toggle autoformatting on save
  (set M.autoformat (not M.autoformat))
  (local lazy-util (require :lazy.core.util))
  (if M.autoformat
      (lazy-util.info "Enabled format on save" {:title :LspFormat})
      (lazy-util.warn "Disabled format on save" {:title :LspFormat})))

(fn M.format []
  ;; Formats the current buffer if autoformat is enabled
  ;; Checks for a formatter and runs the appropriate format command
  (when M.autoformat
    (local {: get-formatter} (require :me.util))
    (local formatter (get-formatter))
    (if (not-nil! formatter)
        (vim.cmd :FormatWrite)
        (M.lsp-format M.client))))

(fn M.lsp-format [client]
  (when (M.support-format client)
    (vim.lsp.buf.format)))

(fn M.support-format [client]
  (if (and (and client.config client.config.capabilities)
           (= client.config.capabilities.documentFormattingProvider false))
      false
      (or (client.supports_method :textDocument/format)
          (client.supports_method :textDocument/rangeFormatting))))

(fn M.setup [client buffer]
  (set M.client client)
  (set M.buffer buffer)
  ;; Attach format on save functionality
  (local augroup (vim.api.nvim_create_augroup :AutoFormatting {}))
  (vim.api.nvim_create_autocmd :BufWritePost
                               {:group augroup :callback #(M.format)}))

M

