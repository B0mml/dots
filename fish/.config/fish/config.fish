# source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/default-config.fish

if not set -q TMUX; and not tmux has-session -t default 2>/dev/null
    tmux -2u new -s default
end

alias cd='z'
alias n='nvim'
alias lg='lazygit'
alias cat='bat'
alias ll='ls -alh'
alias lowfi="lowfi -t chillhop"

function todoo
    todo q "$argv #Inbox"
end

zoxide init fish | source

# potentially disabling fastfetch
function fish_greeting
    # smth smth
end


# Initialize starship once and set up transience
starship init fish | source
function starship_transient_prompt_func
    starship module character
	starship module time
end
enable_transience

thefuck --alias | source
