function cdd
    if test (count $argv) -eq 1
        cd (dirname $argv)
    else
        echo "cdd requires a single argument"
        return 1
    end
end
