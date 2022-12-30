if status is-interactive
    # Commands to run in interactive sessions can go here
end

# -- environment ---------------------------------------------------------------

. $HOME/.config/fish/config.env.fish

# -- homebrew ------------------------------------------------------------------

/opt/homebrew/bin/brew shellenv | source
source /Users/jjarsater/.config/op/plugins.sh

# -- Colors --------------------------------------------------------------------

starship init fish | source

# -- ASDF ----------------------------------------------------------------------

. /opt/homebrew/opt/asdf/libexec/asdf.fish
. ~/.asdf/plugins/java/set-java-home.fish

# -- PATH ----------------------------------------------------------------------

fish_add_path -g \
    /opt/homebrew/opt/curl/bin \
    ~/.asdf/shims \
    ~/.local/share/nvim/mason/bin \
    ~/.cargo/bin

# -- ENV -----------------------------------------------------------------------

set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx GPG_TTY (tty)

set -gx AWS_SDK_LOAD_CONFIG true
set -gx GLOBAL_AUTO_TFVARS ~/.config/terraform/payments.tfvars
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx XDG_CONFIG_HOME /Users/jjarsater/.config/

set -gx APPLE_SSH_ADD_BEHAVIOR macos

# -- ALIAS ---------------------------------------------------------------------

alias cat="bat"
alias n="nvim"
alias vim="nvim"
alias dco="docker-compose"
alias dot="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias tf="terraform"
alias ls="exa"
