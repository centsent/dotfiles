{ ... }:

{
  programs.zsh.shellAliases = {
    l = "eza -al --icons";
    ls = "eza --grid --color --icons --all";
    ll = "eza -l";
    tree = "eza --tree --git-ignore";

    # Use rip, xcp, bat, and procs by name: their flags differ from the
    # standard rm, cp, cat, and ps commands.
    tg = "topgrade";
    pn = "pnpm";

    claudef = "claude --dangerously-skip-permissions";
    codexf = "codex --dangerously-bypass-approvals-and-sandbox";
    agyf = "agy --dangerously-skip-permissions";

    # Pin the on-demand CLI versions; gh is installed directly by packages.nix.
    bw = "bunx @bitwarden/cli@2026.8.0";
    ctx7 = "bunx ctx7@0.5.10";
    copilot = "bunx @github/copilot@1.0.83";
    degit = "bunx degit@3.10.0";
    lighthouse = "bunx lighthouse@13.4.1";
    npkill = "bunx npkill@0.12.2";
    playwright = "bunx @playwright/cli@0.1.19";
    qwen = "bunx @qwen-code/qwen-code@0.23.0";
    wrangler = "bunx wrangler@4.129.0";
  };

  programs.zsh.initContent = ''
    # Run in a subshell so changing to the repository root leaves the caller's
    # directory intact, including when agy fails.
    _agy_commit() (
      emulate -L zsh
      local mode="$1"
      shift

      local root prompt
      root=$(command git rev-parse --show-toplevel) || return
      builtin cd -- "$root" || return

      prompt="The git repository is at $root. Inspect git status --short --untracked-files=all, git diff, git diff --cached, and the contents of untracked files. "

      case "$mode" in
        all)
          prompt+="Stage all changes with git add -A, review git diff --cached, then create one commit with a concise Conventional Commit message. "
          ;;
        grouped)
          # Never unstage the user's work implicitly or let it leak into the
          # first commit of an unrelated group. This also works before HEAD exists.
          if ! command git diff --cached --quiet --; then
            print -u2 -- "aim: commit or unstage existing staged changes before grouping commits."
            return 1
          fi
          prompt+="Group all changes into logical sets based on functionality. Start each group with an empty index. For each group, use git add -A -- with only that group's explicit paths, review git diff --cached to verify it contains only that group, and commit with a descriptive Conventional Commit message. Stop if any step fails. Repeat until all changes are committed. "
          ;;
      esac

      prompt+="If there are no changes, do not create an empty commit. Do NOT push to remote."
      command agy --add-dir "$root" --prompt "$prompt" "$@"
    )

    aic() { _agy_commit all "$@"; }
    aim() { _agy_commit grouped "$@"; }
  '';
}
