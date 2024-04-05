### Personal dot files
I basically just try to have the same development environment on all the systems I use. Alacritty, tmux, neovim, and sometimes vscode + jupyter notebook.

#### Setup programs in `local/src/`
In each respective directory, download the source code for each program from
[suckless.org](https://suckless.org/). Then replace `config.def.h` with mine. Also apply the
patches.

Then run:

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
