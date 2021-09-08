#!/bin/sh
cachedir=${XDG_CACHE_HOME:-"$HOME/.cache"}
histsize=50

if [ -d "$cachedir" ]; then
    cache=$cachedir/emenu
    hist=$cachedir/emenu_hist
else
    cache=$HOME/.emenu_cache # if no xdg dir, fall back to dotfile in ~
    hist=$HOME/.emenu_cache_hist # if no xdg dir, fall back to dotfile in ~
fi

if [ ! -e "$hist" ]; then
    touch "$hist"
    echo foo
fi
cmd=$(
IFS=:
if stest -dqr -n "$cache" $PATH; then
    (tac "$hist" ; stest -flx $PATH | sort -u | tee "$cache" ) | dmenu -p "run" "$@"
else
    (tac "$hist"; cat "$cache") | dmenu "$@"
fi
)

echo "$cmd" | ${SHELL:-"/bin/sh"} &

sed -i -e "/^${cmd}$/d;${histsize}q" "$hist"
echo "$cmd" >> "$hist"
