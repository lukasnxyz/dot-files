#!/bin/sh

# 9 static workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9

# switch to work space i keybinds
# move to work space i keybinds
# disable super num to open applications
for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

# close window
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
# minimize window
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>m']"
# maximize window
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Control><Alt>Return']"
# view split left
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Control><Alt>h']"
# view split right
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Control><Alt>l']"
# take screenshot interactively
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Control><Shift>4']"
# switch through all windows with super tab
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"

# setup custom-keybind list
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
new_binding_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
if [[ "$current_bindings" == "@as []" ]]; then
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$new_binding_path']"
else
  trimmed=${current_bindings%]}
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${trimmed}, '$new_binding_path']"
fi

# custom keybinds
ghostty_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
#brave_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
#nautilus_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ghostty_path name "Ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ghostty_path command "ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ghostty_path binding "<Super>Return"

#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$brave_path name "Brave"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$brave_path command "brave"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$brave_path binding "<Super>w"

#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$nautilus_path name "nautilus"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$nautilus_path command "nautilus -w"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$nautilus_path binding "<Super>f"
