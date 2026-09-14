set -g fish_greeting
set -g _hostname (uname -n)
set _os (uname -s)

fish_add_path --prepend ~/bin/$_os \
    ~/bin \
    ~/.cargo/bin \
    ~/go/bin \
    ~/.rbenv/bin \
    ~/.janet/bin

switch $_os
    case Darwin
        alias ff-update "rm -fr $HOME/Library/Caches/Mozilla/updates"
        /opt/homebrew/bin/brew shellenv | source
        fish_add_path /Applications/Docker.app/Contents/Resources/bin
        fish_add_path --append ~/.docker/bin

    case Linux
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
        alias open=xdg-open

        set -gx DOCKER_HOST unix:///run/user/$UID/podman/podman.sock
        set -gx FLYCTL_INSTALL ~/.fly

        fish_add_path --append \
            $FLYCTL_INSTALL/bin \
            ~/.texlive/2026/bin/x86_64-linux

    case SunOS
        if not infocmp $TERM &>/dev/null
            set -x TERM xterm-256color
            set -x COLORTERM truecolor
        end

        fish_add_path --append /opt/ooce/bin
        set -gx CFLAGS '-std=c99'
        set -gx MAKE gmake
end

if status is-interactive
    set -gx EDITOR hx
    fish_vi_key_bindings
    set fish_cursor_default block blink
    set fish_cursor_insert underscore blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block blink
    command -q rbenv; and rbenv init - --no-rehash fish | source
    command -q zoxide; and zoxide init fish | source
    # command -q starship; and starship init fish | source
    test -f ~/.local/share/fnm/fnm; and ~/.local/share/fnm/fnm env | source
    bind -M insert \cf accept-autosuggestion
end
