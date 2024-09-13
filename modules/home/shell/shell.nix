{config, lib, pkgs,...}:
{
  home.packages = [
    pkgs.pfetch
    pkgs.lolcat
    pkgs.nerdfonts
    pkgs.eza
    pkgs.neovim
  ];  

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path = "${config.xdg.cacheHome}/zshhistory";
    };

    initExtra = ''
      # For vim keybindings
      bindkey -v
      bindkey "^?" backward-delete-char

      # For deleting characters
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word

      # auto/tab complete
      autoload -Uz compinit && compinit -d "${config.xdg.cacheHome}"/zcompdump-"$ZSH_VERSION"
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}'
      zmodload zsh/complist
      compinit -d "${config.xdg.cacheHome}"/zcompdump-"$ZSH_VERSION"
      _comp_options+=(globdots)

      # functions
      ex ()
      {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.tar.xz)    tar xJf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
      
      cd() { builtin cd "$@" && exa --icons --group-directories-first -alh; }
      mock() { builtin echo "$@" | sed 's/\(.\)\(.\)\?/\u\1\2/g'; }

      # Autoload
      pfetch | lolcat
    ''; 
  };

  home.shellAliases = {
    # kitty specific
    ssh="kitty +kitten ssh";
    icat="kitty +kitten icat";
    
    # aliases
    ".."="cd ..";
    "..."="cd ../..";
    "...."="cd ../../..";
    
    ls="exa --icons --group-directories-first";
    ll="ls -alh";
    l="ls -lFh";
    
    grep="grep --color";
    wget="wget --hsts-file='${config.xdg.cacheHome}/wget_history'";
    
    rm="rm -i";
    cp="cp -i";
    mv="mv -i";
    
    vim="nvim";
    vi="vim";
    emacs="emacsclient -c -a emacs";
    
    e="emacsclient -t -a=''";
    v="nvim";
    n="nnn";
    q="exit";
    m="maim -u -s $(date +%m-%d-%Y_%T).png";
    g="grim -g \"$(slurp)\" $(date +%m-%d-%Y_%T).png";
    
    ytogg="yt-dlp -x --audio-format vorbis --embed-metadata --embed-thumbnail";
  };
}
