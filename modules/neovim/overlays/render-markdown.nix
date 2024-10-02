{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "render-markdown";
  version = "latest";

  src = fetchFromGitHub {
      owner = "MeanderingProgrammer";
      repo = "render-markdown.nvim";
      rev = "main";
      sha256 = "sha256-GxlW7/pLaXoh7faAB9bXNG7xONc9L08UzCbkeCuCgfY=";
  };
}
