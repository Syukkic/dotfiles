setenv LESS_TERMCAP_mb \e'[01;31m' # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
setenv LESS_TERMCAP_me \e'[0m' # end mode
setenv LESS_TERMCAP_se \e'[0m' # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m' # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

set -U VISUAL nvim
set -Ux GOPATH $HOME/.go
set -Ua PATH $GOPATH/bin

set -Ua PATH $HOME/.cargo/bin
set -U fish_user_paths $GOPATH/bin $HOME/.cargo/bin $fish_user_paths
# set -Ua PATH "$HOME/.cargo/env:$HOME/.cargo/bin" $PATH

# eval "$(atuin init fish)"
# fzf --fish | source
eval $(opam config env)
