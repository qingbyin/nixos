{ config, pkgs, ... }:

{
  # Do not install kitty using program.kitty because it needs also install OpenGL
  # Install kitty using Ubuntu, so that kitty can use the system OpenGl
  
  xdg.configFile."kitty/kitty.conf" = ./kitty.conf;
  xdg.configFile."kitty/OceanicMaterial.conf" = ./OceanicMaterial.conf;
}
