{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "vim-jukit";
  version = "latest";

  src = fetchFromGitHub {
      owner = "luk400";
      repo = "vim-jukit";
      rev = "master";
      sha256 = "sha256-wWpa08WG0CGQiI3G7g6k2ruSnyAXxmRJ1OW26oyoBgE=";
  };
}
