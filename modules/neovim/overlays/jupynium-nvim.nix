{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "jupyter-nvim";
  version = "latest";

  src = fetchFromGitHub {
      owner = "kiyoon";
      repo = "jupynium.nvim";
      rev = "master";
      sha256 = "sha256-mwTgD8u0z79EvrXLgq9JAwG1bUp/T4spsSJ1Wh7DKdI=";
  };
}
