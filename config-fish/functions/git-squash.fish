function git-squash
    set -l base $argv[1]
    if test -z "$base"
        if git rev-parse --verify main >/dev/null 2>&1
            set base main
        else
            set base master
        end
    end

    set -l target (git merge-base $base HEAD)
    if test $status -ne 0
        echo "Error: Could not find merge base with $base."
        return 1
    end

    git reset --soft $target
    if test $status -ne 0
        echo "Error: git reset --soft failed."
        return 1
    end

    echo "successfully reset to $base ($target)"
    echo "Run 'git commit -m \"commit message\"' to finalize"
end
