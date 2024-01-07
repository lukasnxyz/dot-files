### Personal dot files
These are all the very basic things that I use and have configured on my Arch/Suckless system.

#### Setup programs in `local/src/`
In each respective directory, run:
```bash
$ sudo make install
```
To have slock run on suspend, create this file: `/etc/systemd/system/slock@.service`
```bash
[Unit]
Description=slock for %i
Before=suspend.target

[Service]
User=%i
Type=forking
Environment=DISPLAY=:0
Environment="XAUTHORITY=/run/user/1000/Xauthority"
ExecStart=/usr/local/bin/slock

[Install]
WantedBy=suspend.target
```
And run `sudo systemctl enable slock@<your_user_name>.service`

#### Neovim setup
Make sure you have [packer](https://github.com/wbthomason/packer.nvim#quickstart) installed.
