#!/usr/bin/env bash
selected=`cat ~/.dotfiles/tmux/.tmux-cht-languages ~/.dotfiles/tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.dotfiles/tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    echo "language"
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    echo "command" 
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

