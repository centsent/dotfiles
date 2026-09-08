{ pkgs }:
{
  fzf-tab = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "24105b15714bfec37989ed5c5b6e60f572253019";
    hash = "sha256-YhTSu0P7mFlVx1zBvbT0jNstkamcZHhPYJHKMAHgyuM=";
  };
  tmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "58a3dcc0d718ec0fa1c0d5a2fddd640a1ad7a5b7";
    hash = "sha256-YDzbZVFhrAMBhOI8HVDxR3rEPkrEwG57IUbnZicmfn4=";
  };
  yazi-office = pkgs.fetchFromGitHub {
    owner = "macydnah";
    repo = "office.yazi";
    rev = "41ebef8be9dded98b5179e8af65be71b30a1ac4d";
    hash = "sha256-QFto48D+Z8qHl7LHoDDprvr5mIJY8E7j37cUpRjKdNk=";
  };
  yazi-kanagawa = pkgs.fetchFromGitHub {
    owner = "dangooddd";
    repo = "kanagawa.yazi";
    rev = "04985d12842b06bdb3ad5f1b3d7abc631059b7f5";
    hash = "sha256-Yz0zRVzmgbrk0m7OkItxIK6W0WkPze/t09pWFgziNrw=";
  };
}
