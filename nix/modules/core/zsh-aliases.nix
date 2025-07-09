{ ... }:

{
  programs.zsh.shellAliases = {
    l = "eza -al --icons";
    ls = "eza --grid --color --icons --all";
    ll = "eza -l";
    rm = "rip";
    cp = "xcp";
    tg = "topgrade";
    cat = "bat";
    ps = "procs";
    pn = "pnpm";

    se = "sudo emerge --ask --verbose";
  };
}
