if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n (hostnamectl hostname)
    if [ $PWD != $HOME ]
        set_color brblack
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '| '
    set_color normal
end

function fish_greeting
    echo
    echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	  # echo -e (pacman -Qu | wc -l | awk '{print " \\\\e[1mPackage: \\\\e[0;32m"$0"\\\\e[0m"}')

    echo -e " \\e[1mNetwork:\\e[0m"
    echo
    # http://tdt.rocks/linux_network_interface_naming.html
    echo -ne (\
		ip addr show up scope global | \
			grep -E ': <|inet' | \
			sed \
				-e 's/^[[:digit:]]\+: //' \
				-e 's/: <.*//' \
				-e 's/.*inet[[:digit:]]* //' \
				-e 's/\/.*//'| \
			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
			sort | \
			column -t -R1 | \
			# public addresses are underlined for visibility \
			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
			# private addresses are not \
			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
			# unknown interfaces are cyan \
			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
			# ethernet interfaces are normal \
			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
			# wireless interfaces are purple \
			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
			# wwan interfaces are yellow \
			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
			sed 's/$/\\\e[0m/' | \
			sed 's/^/\t/' \
		)
    echo

    set_color normal
end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/yuki/.opam/opam-init/init.fish' && source '/home/yuki/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration


function __proxy_enable
    set IP 127.0.0.1
    set PORT 8080
    set PROT socks5
    set OPT -gx

    if test (count $argv) -gt 0
        for arg in $argv
            switch $arg
                case "-non-global"
                    set OPT "-x"
                case -socks -socks5     # set socks proxy (local DNS)
                    set PROT socks5
                case -socks5h           # set socks proxy (remote DNS)
                    set PROT socks5h
                case -http              # set HTTP proxy
                    set PROT http
                case '*'
                    if string match -qr '^[0-9]+$' -- "$arg"
                        set PORT "$arg"
                    else
                        echo "Invalid argument: $arg" >&2
                        return 1
                    end
            end
        end
    end

    set PROXY "$PROT://$IP:$PORT"

    echo "set $OPT HTTP_PROXY $PROXY"
    echo "set $OPT HTTPS_PROXY $PROXY"
    echo "set $OPT ALL_PROXY $PROXY"
    echo "set $OPT NO_PROXY localhost,127.0.0.1"
end

function proxy_enable
    eval (__proxy_enable $argv)
end

function proxy_disable
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    set -e ALL_PROXY
    set -e NO_PROXY
end

# uv
fish_add_path "/home/yuki/.local/bin"
