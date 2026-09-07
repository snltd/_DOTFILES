function cdt
    set -l top (git rev-parse --show-toplevel 2>/dev/null)

    if test -n "$top"
        cd $top
    else
        echo "not inside a git repository" >&2
        return 1
    end
end
