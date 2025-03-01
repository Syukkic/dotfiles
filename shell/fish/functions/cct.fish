function cct
    if test (count $argv) -lt 2
        echo "Usage: cct [t2s|s2t] text"
        return 1
    end
    switch $argv[1]
        case "t2s"
            echo $argv[2..-1] | opencc -c t2s.json
        case "s2t"
            echo $argv[2..-1] | opencc -c s2t.json
        case "*"
            echo "Invalid option. Use 't2s' for Traditional to Simplified or 's2t' for Simplified to Traditional."
            return 1
    end
end

