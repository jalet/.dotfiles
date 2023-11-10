#!/usr/bin/fish

function n --description 'Open neovim in the current directory of file if first argument is provided.'
    if set -q $argv[1]
        nvim $PWD
    else
        nvim $argv[1]
    end
end


