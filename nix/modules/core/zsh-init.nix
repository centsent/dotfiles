{ config, pkgs, ... }:

{
  programs.zsh.initExtra = ''
    # Custom configuration for zsh-autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7dcfff,bg=#1a1b26,underline"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
  '';
}
