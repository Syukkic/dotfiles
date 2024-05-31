function lk {
  cd "$(walk "$@")"
}

    function onesync {

    exclusion="{.stignore,.stfolder/**,.git/**,Element/**}"

    echo "=====  Start synchronizing ebooks  ===== "
    rclone sync ~/Documents/Library/ OneDrive:/ebooks/ -P --exclude ${exclusion}
    rclone sync ~/Documents/Calibre\ Library/ OneDrive:/CalibreL\ Library/ -P --exclude ${exclusion}
    echo "=====  Start synchronizing Music  ===== "
    rclone sync ~/Music/ OneDrive:/Music/ -P --exclude ${exclusion}
}

        function curltime() {
    # https://stackoverflow.com/a/22625150
    curl -w @$HOME/Repos/dotfiles/scripts/curl-format.txt -o /dev/null -s $1
}


            # convert any format of image to webp format
            # requirements:
            #     ImageMagick: https://wiki.archlinux.org/title/ImageMagick
            #     try: https://github.com/binpash/try
            function c2webp() {
    filename=$(basename "$1")
    filename_without_extension=${filename%.*}
    convert $1 -quality 10 ${filename_without_extension}.webp
    echo "${filename_without_extension}.webp converted!"
    try rm $filename
}


                # DNS
                # https://github.com/ogham/dog
                function dns () { if [[ "$#" -eq 1 ]]; then
        dog --tls "@1.1.1.1:853" A AAAA NS MX TXT $@
	# dog --https "@https://dns.alidns.com/dns-query" A AAAA NS MX TXT $@
    else
        dog --tls "@1.1.1.1:853" A AAAA $@
    fi
}


                    # Download YouTube Music
                    function ytm() {
    if [[ $@ == *"playlist"* ]]; then
        echo "$@"
        yt-dlp -x -f "bestaudio[ext=m4a]"                       \
            --add-metadata --embed-thumbnail                    \
            --parse-metadata "playlist_index:%(track_numbers)s" \
            -o "~/Music/%(playlist_index)s %(title)s.%(ext)s"   \
            $@
    else
        yt-dlp -x -f "bestaudio[ext=m4a]"                       \
            --add-metadata --embed-thumbnail                    \
            -o "~/Music/%(title)s.%(ext)s"                      \
            $@
    fi
}

                        # https://yazi-rs.github.io/docs/quick-start
                        function ya() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
