(local formatters_by_ft {:bash [:shfmt]
                         :c [:clang_format]
                         :cpp [:clang_format]
                         :cs [:csharpier]
                         :css [:prettier]
                         :fennel [:fnlfmt]
                         :fish [:fish_indent]
                         :go [:goimports :gofumpt :golines]
                         :graphql [:prettier]
                         :html [:prettier]
                         :haskell [:fourmolu]
                         :java [:google-java-format]
                         :javascript [:biome :biome-check]
                         :javascriptreact [:biome :biome-check]
                         :json [:biome]
                         :jsonc [:prettier]
                         :kotlin [:ktlint :ktfmt]
                         :lua [:stylua]
                         :markdown [:prettier]
                         :markdown.mdx [:prettier]
                         :objetive-c [:clang_format]
                         :php [:phpcbf]
                         :python [:ruff]
                         :ruby [:rubocop]
                         :scss [:prettier]
                         :scala [:scalafmt]
                         :swift [:swiftformat]
                         :svelte [:prettier]
                         :svg [:prettier]
                         :toml [:taplo]
                         :typescript [:biome :biome-check]
                         :typescriptreact [:biome :biome-check]
                         :rust [:rustfmt]
                         :vue [:prettier]
                         :xml [:prettier]
                         :yaml [:prettier]
                         :zig [:zigfmt]
                         :_ [:trim_whitespace]})

(fn format_on_save [_]
  (local autoformat (. (require :me.config) :autoformat))
  (when autoformat
    {:timeout_ms 2000 :lsp_fallback true}))

(local opts {: formatters_by_ft : format_on_save})

{1 :stevearc/conform.nvim : opts :event [:BufWritePre]}
