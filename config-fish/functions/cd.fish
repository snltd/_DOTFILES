function cd
    if test (count $argv) -eq 2
        set newpath (echo $PWD | sed "s|\(.*\)$argv[1]|\1$argv[2]|")
        builtin cd $newpath
    else
        z $argv
    end
end
