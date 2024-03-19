{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      export LOCALIP=127.0.0.1
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
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = "autopair.zsh";
        name = "autopair";
        src = "${zsh-autopair}/share/zsh/zsh-autopair";
      }
      {
        file = "zsh-z.zsh";
        name = "zsh-z";
        src = "${zsh-z}/share/zsh-z";
      }
    ];
  };

  home.file.".p10k.zsh".source =./.p10k.zsh;
}
