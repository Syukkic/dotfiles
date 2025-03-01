# Download YouTube Music
function ytm 
    if string match -q -- "*playlist*" $argv
        yt-dlp \
            --extract-audio \
            --format "bestaudio" \
            --audio-format "mp3" \
            --add-metadata --embed-thumbnail \
            --parse-metadata "playlist_index:%(track_numbers)s" \
            --output "~/Music/%(playlist_index)s-%(title)s.%(ext)s" \
            $argv
    else if string match -q -- "*split-chapter*" $argv
        # e.g.  [ ytm --split-chapter "https://www.youtube.com/watch?v=xkDlet4cxuQ" ]
        yt-dlp \
            --extract-audio \
            --format "bestaudio" \
            --audio-format "mp3" \
            #--paths temp:"/tmp" \
            --paths "~/Music" \
            --split-chapter \
            #--add-metadata --embed-chapters \
            --add-metadata --embed-metadata \
            --output "chapter:%(section_number)s - %(section_title)s.%(ext)s" \
            $argv
    else
        yt-dlp \
            --extract-audio \
            --format "bestaudio" \
            --audio-format "mp3" \
            --add-metadata --embed-thumbnail \
            --output "~/Music/%(title)s.%(ext)s" \
            $argv
    end
end
