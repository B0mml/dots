if test -f "$HOME/.atuin/bin/env.fish"
    source "$HOME/.atuin/bin/env.fish"
end
if command -v atuin >/dev/null
    atuin init fish | string replace -r 'bind -M insert -k up' 'bind -M insert up' | source
end
