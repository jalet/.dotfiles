if status is-interactive
    # Commands to run in interactive sessions can go here
end

# -- environment ---------------------------------------------------------------

. $HOME/.config/fish/config.env.fish

# -- homebrew ------------------------------------------------------------------

# /opt/homebrew/bin/brew shellenv | source
# source /Users/jjarsater/.config/op/plugins.sh

# -- Colors --------------------------------------------------------------------

starship init fish | source

# -- ASDF ----------------------------------------------------------------------

# . /opt/homebrew/opt/asdf/libexec/asdf.fish
# . ~/.asdf/plugins/java/set-java-home.fish

# -- PATH ----------------------------------------------------------------------

fish_add_path -g ~/.local/share/nvim/mason/bin \
    ~/.cargo/bin \
    ~/.local/bin \
    /usr/local/go/bin 
# -- ENV -----------------------------------------------------------------------

set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx GPG_TTY (tty)

set -gx AWS_SDK_LOAD_CONFIG true
set -gx XDG_CONFIG_HOME $HOME/.config/

# -- ALIAS ---------------------------------------------------------------------

alias cat="bat"
alias vim="nvim"
alias dco="docker-compose"
alias cfg="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias tf="terraform"
alias ls="exa"
