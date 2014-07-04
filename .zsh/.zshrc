# https://github.com/catatsuy/dot.zsh/blob/master/.zshrc
# fpath=($ZDOTDIR/functions/completions/src(N-/) $ZDOTDIR/functions/docker-zsh-completion(N-/) $ZDOTDIR/functions/padrino-zsh-completion(N-/) ${fpath})

autoload -Uz compinit
compinit -u

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt share_history
setopt auto_pushd
setopt pushd_ignore_dups
setopt complete_aliases
setopt list_packed
setopt nolistbeep
setopt transient_rprompt
setopt hist_no_store
setopt auto_menu
setopt extended_glob
setopt notify
setopt nonomatch

bindkey -e

PROMPT="%n@%m%% "

typeset -U path cdpath fpath manpath

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

zstyle ':completion:*' ignore-parents parent pwd ..

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey "^[[Z" reverse-menu-complete

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# load .zshrc_*
[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_external ] && . $ZDOTDIR/.zshrc_external
[ -f $ZDOTDIR/.zshrc_alias    ] && . $ZDOTDIR/.zshrc_alias
[ -f $ZDOTDIR/.zshrc_misc     ] && . $ZDOTDIR/.zshrc_misc
[ -f $ZDOTDIR/.zshrc_local    ] && . $ZDOTDIR/.zshrc_local


if [ -d ${HOME}/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  . ~/.rbenv/completions/rbenv.zsh
fi

