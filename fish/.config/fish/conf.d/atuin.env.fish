<<<<<<< HEAD
if test -f "$HOME/.atuin/bin/env.fish"
    source "$HOME/.atuin/bin/env.fish"
end
if command -v atuin >/dev/null
    atuin init fish | string replace -r 'bind -M insert -k up' 'bind -M insert up' | source
=======
source "$HOME/.atuin/bin/env.fish"
# atuin init fish | source
# Workaround für Fish 4.0 und Atuin (entfernt das veraltete -k Flag)
if status is-interactive
    atuin init fish | sed 's/-k up/up/' | source
>>>>>>> 70caed4428adccd3612927985b10f589be4e14e3
end
