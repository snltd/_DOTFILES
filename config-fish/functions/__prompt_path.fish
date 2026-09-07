function __prompt_path
    set -l p (pwd)
    set -l home $HOME

    if string match -q "$home*" $p
        set p "~"(string replace "$home" "" $p)
    end

    echo $p
end
