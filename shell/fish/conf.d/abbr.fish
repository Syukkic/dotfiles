# https://github.com/lsd-rs/lsd
abbr -a ls lsd
abbr -a ll 'lsd -l'
abbr -a la 'lsd -a'
abbr -a lla 'lsd -la'
abbr -a lt 'lsd --tree'

## entrance
abbr -a .. "cd .."
abbr -a ... "cd ..; cd .."
abbr -a de "cd ~/Desktop"
abbr -a dot "cd ~/Repos/dotfiles"
abbr -a blog "cd ~/Repos/blog"

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
abbr -a zed "zeditor"
abbr -a mutt "neomutt"

abbr -a orphans "sudo pacman -Qtdq | sudo pacman -Rns -"
abbr -a install "sudo pacman -S"
abbr -a upgrade "sudo pacman -Syu"
abbr -a remove "sudo pacman -Rns"
abbr -a search "pacman -Ss"
