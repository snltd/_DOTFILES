function fish_prompt
    # OSC 7 - report cwd so wezterm knows where you are for new tabs/panes
    printf "\e]7;file://%s%s\e\\" (uname -n) (pwd)

    # OSC 133 - semantic prompt mark
    printf "\e]133;A\e\\"

    set -l pwd_colour 999999
    set_color $pwd_colour

    if set -q SSH_TTY
        set host (uname -n)
        set_color --bold
        echo -n $host
        set_color --reset $pwd_colour
        echo -n :
    end

    set -l path (__prompt_path)
    set -l branch ""

    if command -q git
        set branch (command git symbolic-ref --quiet --short HEAD 2>/dev/null)
    end

    echo -n "$path"
    set_color normal

    if test -n "$branch"
        set -l dirty (command git status --porcelain 2>/dev/null)
        if test -n "$dirty"
            set_color D3762B
        else
            set_color green
        end

        echo -n "  $branch"
        set_color normal
    end

    echo

    set -l color green

    if test -n "$exit_code" -a "$exit_code" -ne 0
        set color red
    end

    set_color $color

    echo -n "\$ "

    set_color normal
end
