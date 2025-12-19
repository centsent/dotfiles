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

    bw = "bunx @bitwarden/cli";
    claude = "bunx @anthropic-ai/claude-code";
    claudef = "bunx @anthropic-ai/claude-code --dangerously-skip-permissions";
    codex = "bunx @openai/codex";
    codexf = "bunx @openai/codex --dangerously-bypass-approvals-and-sandbox";
    copilot = "bunx @github/copilot";
    degit = "bunx degit";
    gemini = "bunx @google/gemini-cli";
    aic = ''
      bunx @google/gemini-cli -y -m "gemini-2.5-flash" "Analyze the current git diff. Execute 'git add -A' and then execute 'git commit' with a concise message following the Conventional Commits specification (e.g., 'feat: ...', 'fix: ...'). Do NOT push to remote."'';
    aim = ''
      bunx @google/gemini-cli -y -m "gemini-2.5-flash" "Analyze all modified files. Group them into logical sets based on functionality. For each set: 1. Execute 'git add' for those specific files only. 2. Execute 'git commit' with a descriptive Conventional Commit message. Repeat until all changes are committed. Do NOT push"'';
    gh = "bunx gh";
    lighthouse = "bunx lighthouse";
    npkill = "bunx npkill";
    qwen = "bunx @qwen-code/qwen-code";

    wrangler = "bunx wrangler";
  };
}
