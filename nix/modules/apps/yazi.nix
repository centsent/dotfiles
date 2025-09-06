{ pkgs, ... }:

let
  yazi-office-plugin = pkgs.fetchFromGitHub {
    owner = "macydnah";
    repo = "office.yazi";
    rev = "main";
    hash = "sha256-/zFSyVzyJLvNINB5vD5RlOimdhQT0WrmjjDUIhNlyj4=";
  };
  kanagawa-flavor = pkgs.fetchFromGitHub {
    owner = "dangooddd";
    repo = "kanagawa.yazi";
    rev = "main";
    hash = "sha256-nGFiAgVWfq7RkuGGCt07zm3z7ZTGiIPIR319ojPfdUk=";
  };
in {
  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "mtime";
        sort_dir_first = true;
        sort_reverse = true;
        show_symlink = true;
      };
      plugin = {
        prepend_preloaders = [
          {
            mime = "application/openxmlformats-officedocument.*";
            run = "office";
          }
          {
            mime = "application/oasis.opendocument.*";
            run = "office";
          }
          {
            mime = "application/ms-*";
            run = "office";
          }
          {
            mime = "application/msword";
            run = "office";
          }
          {
            name = "*.docx";
            run = "office";
          }
        ];

        prepend_previewers = [
          {
            mime = "application/openxmlformats-officedocument.*";
            run = "office";
          }
          {
            mime = "application/oasis.opendocument.*";
            run = "office";
          }
          {
            mime = "application/ms-*";
            run = "office";
          }
          {
            mime = "application/msword";
            run = "office";
          }
          {
            name = "*.docx";
            run = "office";
          }
        ];
      };
    };
  };

  xdg.configFile."yazi/plugins/office.yazi" = { source = yazi-office-plugin; };

  xdg.configFile."yazi/flavors/kanagawa.yazi" = { source = kanagawa-flavor; };
  xdg.configFile."yazi/theme.toml" = {
    text = ''
      [flavor]
      dark = "kanagawa"
    '';
  };
}
