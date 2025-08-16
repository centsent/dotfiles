{ ... }:

{
  programs.zsh.shellAliases = {
    l = "eza -al --icons";
    ls = "eza --grid --color --icons --all";
    ll = "eza -l";
    tree = "eza --tree --git-ignore";

    rm = "rip";
    cp = "xcp";
    tg = "topgrade";
    cat = "bat";
    ps = "procs";
    pn = "pnpm";

    claude = "bunx @anthropic-ai/claude-code";
    codex = "bunx @openai/codex";
    degit = "bunx degit";
    gemini = "bunx @google/gemini-cli";
    lighthouse = "bunx lighthouse";
    npkill = "bunx npkill";
    qwen = "bunx @qwen-code/qwen-code";

    wrangler = "bunx wrangler";
  };
}
