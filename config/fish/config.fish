set fish_greeting

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

function fish_user_key_bindings
    fish_vi_key_bindings
end

alias q='exit'

if status is-interactive
    # Commands to run in interactive sessions can go here
end
