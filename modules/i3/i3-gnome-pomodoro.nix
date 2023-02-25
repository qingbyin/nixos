with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage rec {
  pname = "i3-gnome-pomodoro";

  src = fetchFromGitHub {
    owner = "kantord";
    repo = "${pname}";
  };
  propagatedBuildInputs = [ pytest numpy pkgs.libsndfile ];
}
