#!/usr/bin/env fish

function update-completions
    set outdir ~/.config/fish/completions
    mkdir -p $outdir

    for tool in aur img-tool vid-tool zedfs
        $tool completions fish >$outdir/$tool.fish
    end
end
