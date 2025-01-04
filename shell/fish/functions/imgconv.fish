# Convert any format img to webp for posting on Misskey

function imgconv
    for i in *.$argv;
        set filename (path basename $i | string replace $argv "webp")
        magick -quality 10  $i $filename;
    end
end
