# Download YouTube Music
function ytm
    if string match -q -- "*playlist*" $argv
        # if [ $argv == *"playlist"* ]
        yt-dlp -x -f "bestaudio[ext=m4a]" \
            --add-metadata --embed-thumbnail \
            --parse-metadata "playlist_index:%(track_numbers)s" \
            -o "~/Music/%(playlist_index)s %(title)s.%(ext)s" \
            $argv
    else
        yt-dlp -x -f "bestaudio[ext=m4a]" \
            --add-metadata --embed-thumbnail \
            -o "~/Music/%(title)s.%(ext)s" \
            $argv
    end
end
