{pkgs, fetchFromGitHub}:

pkgs.vimUtils.buildVimPlugin {
  pname = "obsidian-nvim";
  version = "latest";

  src = fetchFromGitHub {
      owner = "oflisback";
      repo = "obsidian-bridge.nvim";
      rev = "main";
      sha256 = "sha256-91g6iy8yWva/nu5N8YDhvotJskKlQyR1/KobgAAV7vw=";
  };
}
