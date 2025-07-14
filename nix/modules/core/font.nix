{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Programming & Terminal Fonts ---
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    sarasa-gothic # Excellent for mixed CJK and programming

    # --- UI & General Purpose Fonts ---
    inter
    font-awesome

    # --- CJK & Emoji Fonts ---
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    # --- For Web & Document Compatibility ---
    corefonts
  ];

  fonts.fontconfig = {
    enable = true;
    # Set the default font fallback order. This tells the system which font to
    # try first, and which to use if a character is not found.
    defaultFonts = {
      serif = [ "Noto Serif" "Noto Sans CJK SC" ];
      sansSerif = [ "Inter" "Noto Sans CJK SC" ];
      monospace = [ "FiraCode Nerd Font" "Sarasa Gothic" "Noto Sans CJK SC" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
