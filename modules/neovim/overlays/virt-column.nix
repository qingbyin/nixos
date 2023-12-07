{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "virt-column";
  version = "v0.80";

  src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "virt-column.nvim";
      rev = "v1.5.6";
      sha256 = "sha256-dLr6ZZ88F3GYjp2TXKCdtQW8z/yZPfbfx/y74xeqeSE=";
  };
}
