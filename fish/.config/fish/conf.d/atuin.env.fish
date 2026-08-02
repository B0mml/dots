if test -f "$HOME/.atuin/bin/env.fish"
    source "$HOME/.atuin/bin/env.fish"
end

if status is-interactive; and command -v atuin >/dev/null
    # Workaround for Fish 4.0 and Atuin (removes deprecated -k flag)
    atuin init fish | string replace -r 'bind -M insert -k up' 'bind -M insert up' | source
end

