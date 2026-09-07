# Approximates the behaviour of ksh's r command
function r
    if test (count $argv) -eq 1
        set pattern (string escape --style=regex -- $argv[1])
        set cmd (history | grep -v '^\s*r\b' | grep -- "^$pattern" | head -1)
    else
        set cmd (history | grep -v '^\s*r\s*$' | head -1)
    end

    echo $cmd
    eval $cmd
end
