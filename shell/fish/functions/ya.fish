# https://yazi-rs.github.io/docs/quick-start
function ya
    set tmp "$(mktemp -t "yazi-cwd.XXXXX")"
    yazi $argc --cwd-file="$tmp"
    if set cwd "$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
        rm -f -- "$tmp"
    end
end
