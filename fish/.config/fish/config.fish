# source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/default-config.fish

if not set -q TMUX; and not tmux has-session -t default 2>/dev/null
    tmux -2u new -s default
end


alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias un='paru -Rns' # uninstall package
alias up='paru -Syu' # update system/package/aur
alias pl='paru -Qs' # list installed package
alias pa='paru -Ss' # list availabe package
alias pc='paru -Sc' # remove unused cache
alias po='paru -Qtdq | paru -Rns -' # remove unused packages, also try > paru -Qqd | paru -Rsu --print -

alias cd='z'
alias n='nvim'
alias lg='lazygit'
alias cat='bat'
alias ll='ls -alh'
alias lowfi="lowfi -t chillhop"
alias claude="~/.claude/local/claude"

function todoo
    todo q "$argv #Inbox"
end

function ex
    if test -f $argv[1]
        switch $argv[1]
            case "*.tar.bz2"
                tar xjf $argv[1]
            case "*.tar.gz"
                tar xzf $argv[1]
            case "*.tar.xz"
                tar xJf $argv[1]
            case "*.bz2"
                bunzip2 $argv[1]
            case "*.rar"
                unrar x $argv[1]
            case "*.gz"
                gunzip $argv[1]
            case "*.tar"
                tar xf $argv[1]
            case "*.tbz2"
                tar xjf $argv[1]
            case "*.tgz"
                tar xzf $argv[1]
            case "*.zip"
                unzip $argv[1]
            case "*.Z"
                uncompress $argv[1]
            case "*.7z"
                7z x $argv[1]
            case "*"
                echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
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

