export ZSH="$HOME/.oh-my-zsh"

if [[ ! -d $ZSH ]]; then
    git clone "https://github.com/ohmyzsh/ohmyzsh" $ZSH
fi

ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"

if command -v nvim > /dev/null; then
    export EDITOR="nvim"
else
    export EDITOR="vi"
fi

if [[ -z $TMUX ]]; then
        tmux attach -t TMUX || tmux new-session -s TMUX
fi

fuzzy_find() {
    local selected=$(find $HOME -mindepth 1 -maxdepth 1 -not -path "$HOME/.*" -type d -exec basename {} \; | fzf)

    if [[ -z $selected ]]; then
        return 1
    else
        cd "$HOME/$selected"
    fi
}

bindkey -s "^f" "fuzzy_find; clear\n"
