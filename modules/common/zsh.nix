{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      set_sys_proxy() {
          export all_proxy=socks5://$LOCALIP:9000
          export https_proxy=socks5://$LOCALIP:9000
          export http_proxy=socks5://$LOCALIP:9000
          curl http://ip-api.com/json
      }
      unset_http_proxy() {
          unset all_proxy
          unset https_proxy
          unset http_proxy
          git config --global --unset http.proxy
      }
      # Environment settings for this specific machine
      if [[ -r "$HOME/.userenv.sh" ]]; then
          source "$HOME/.userenv.sh"
      fi
    '';
  };

  home.packages = with pkgs; [
    zsh-z
    zsh-powerlevel10k
    zsh-autopair
  ];
}
