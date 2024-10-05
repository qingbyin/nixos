# benefit from
# ref: https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
# ref: https://gist.github.com/nat-418/493d40b807132d2643a7058188bff1ca
{user, repo, ref ? "HEAD", buildScript ? ":"}:

let
  pkgs = import <nixpkgs> {};
in

pkgs.vimUtils.buildVimPlugin {
  pname = "${pkgs.lib.strings.sanitizeDerivationName repo}";
  version = ref;
  src = builtins.fetchGit {
    url = "https://github.com/${user}/${repo}.git";
    inherit ref;
  };
  inherit buildScript;
}
