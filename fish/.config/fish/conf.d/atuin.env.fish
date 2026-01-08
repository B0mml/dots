source "$HOME/.atuin/bin/env.fish"
# atuin init fish | source
# Workaround für Fish 4.0 und Atuin (entfernt das veraltete -k Flag)
if status is-interactive
    atuin init fish | sed 's/-k up/up/' | source
end
