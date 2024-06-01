function curltime
    # https://stackoverflow.com/a/22625150
    curl -w @$HOME/Repos/dotfiles/scripts/curl-format.txt -o /dev/null -s $argv
end
