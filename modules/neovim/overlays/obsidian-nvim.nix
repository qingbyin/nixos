{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "obsidian-nvim";
  version = "v2.3.1";

  src = fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "v2.3.1";
      sha256 = "sha256-g9GFq5FMaCcJ6HbnhRgCmioLvaJ4SK6jSioDi5lXeP4=";
  };
}
