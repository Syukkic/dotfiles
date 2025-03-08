# https://github.com/lsd-rs/lsd
abbr -a ls exa
abbr -a ll 'exa -l'
abbr -a la 'exa -a'
abbr -a lla 'exa -la'
abbr -a lt 'exa --tree'

## entrance
abbr -a .. "cd .."
abbr -a ... "cd ..; cd .."
abbr -a de "cd ~/Desktop"
abbr -a dot "cd ~/Repos/dotfiles"
abbr -a blog "cd ~/Repos/Mine/blog/"
abbr -a vimconf "nvim ~/Repos/dotfiles/nvim/"

abbr -a start "sudo systemctl start"
abbr -a stop "sudo systemctl stop"
abbr -a restart "sudo systemctl restart"
abbr -a status "sudo systemctl status"
abbr -a enable "sudo systemctl enable"
abbr -a disable "sudo systemctl disable"

abbr -a yt yt-dlp
# abbr -a tlmgr "tllocalmgr"
abbr -a tlmgr 'TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
abbr -a pc proxychains4
abbr -a pmpv "proxychains4 mpv"
abbr -a tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"
abbr -a vim nvim
abbr -a fsssh "sshfs yuki@192.168.50.20:/mnt/btrfs-hdd/ ~/Public/"
abbr -a ufsssh "fusermount3 -u ~/Public"
abbr -a myip "curl -s wtfismyip.com/json"
abbr -a gc "git clone"
abbr -a gts "git status"
abbr -a steam "flatpak run com.valvesoftware.Steam"
abbr -a wine "flatpak run --command=winetricks org.winehq.Wine"
abbr -a zed "zeditor"
abbr -a mutt "neomutt"
abbr -a wrename "wezterm cli set-tab-title"

abbr -a orphans "sudo pacman -Qtdq | sudo pacman -Rns -"
abbr -a install "sudo pacman -S"
abbr -a upgrade "sudo pacman -Syu"
abbr -a remove "sudo pacman -Rns"
abbr -a search "pacman -Ss"
abbr -a qserach "pacman -Qi"

abbr -a setproxy "set -x all_proxy socks5://127.0.0.1:8080"
abbr -a unsetproxy "set -e all_proxy"









