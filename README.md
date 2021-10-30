# FVWM on Ubuntu 21.04
[FVWM](https://www.fvwm.org/) is an ICCCM-compliant multiple virtual desktop window manager for the X Window system. It is configured by editing text-based configuration files. 

I use fvwm 3.1.0.4 vesion.

## Install fvwm and quick start

Install the [FVWM3](https://github.com/fvwmorg/fvwm3/blob/master/dev-docs/INSTALL.md) package.


#### Test and Try basic fvwm configuration

I use the default configuration files in `fvwm3/default-config/*` as my starting point. So, I copy those configuration files  to `~/.fvwm` directory with the following command:

```shell
# copy fvwm3/default-config github directory to ~/.fvwm.
sudo cp -r /usr/local/share/fvwm3/default-config/* ~/.fvwm

sudo chown -R someuser ~/.fvwm

sudo rm -r /usr/local/share/fvwm3/default-config
```
#### Build ~/.xinitrc file

The xinit program allows a user to manually start an Xorg display server.  

More details: https://wiki.archlinux.org/title/Xinit

My `~/.xinitrc` is 



Avoiding too many environment variables leads to a lot of "pollution" within FVWM's evironment space,
we should use `InfoStoreAdd`. 

This [thread](See: https://web.archive.org/web/20060926032424/http://fvwm.lair.be/viewtopic.php?t=1505) may help you to understand.

```
# ----------------------- set env --------------------------------------

ImagePath $[FVWM_USERDIR]/images:+

# InfoStoreAdd can be used to store variable data internal to fvwm.
# The variable can then be used in the configuration as $[infostore.name].

InfoStoreAdd terminal xterm
InfoStoreAdd gnome-terminal gnome-terminal by

# This is used for "Run Command" and the Meta+Space key-binding.
# runcmd is the binary name and runcmdopt contains additional
# command line options.
InfoStoreAdd runcmd "dmenu_run"
InfoStoreAdd runcmdopt "-nb '#2b4e5e'"

DesktopConfiguration global

# ---------------------------------------------------------------------

```


## 1. Start fvwm3
1.1 copy all  fvwm3 default config files([fvwm3/default-config](https://github.com/fvwmorg/fvwm3/tree/master/default-config)) to `~/.fvwm/`

1.2 configure  `~/.xinitrc`
Rename your `.xinitrc` to `.xinitrc_backup`, and then new a `.xinitrc` file. My '.xinitrc' file:
```
#!/usr/bin/env bash
# Start xterms

exec fvwm3
```

Then `chmod +x ~/.xinitrc`

More details about how to custom x session: [CustomXSession](https://wiki.ubuntu.com/CustomXSession) 

1.3 logout current GNOME desktop env and run fvwm3
Run command line:
```
logout
```

Ctrl + Alt + F2, open tty2:

```
startx
```

If you want to return GNOME 3, just run: `Ctrl + Alt + F1`

To make GDM run your .xinitrc script, you have to link it to .xsession with the following command:

```shell
ln -s ~/.xinitrc ~/.xsession

```

# 启动fvwm

if are running ubuntu with GNONE, must logout gnome-display-manager:

cmd : `ctrl +alt + F2`

```
sudo systemctl disable gdm3
sudo service gdm3 stop
sudo systemctl status gdm3

startx

```

## 增加
# 重新替换配置
fvwm -r

Try to take over from a previously running wm(Gnome's WM). 

## Recommadate
https://wiki.archlinux.org/title/FVWM

## gnome
gnome-control-center

dbus-launch --exit-with-session ~/.xinitrc

XDG_SESSION_TYPE=wayland dbus-run-session ~/.xinitrc
 fcitx-configtool

## IBus & install input method (you don't need do this)

```shell
# --------------------- input method & language setting----------------
# NOT necessary for you.
# For my case, I use Chinese input method ibus-rime.

# 1. Set IBus environment variables. 
# Or add those variables into file `/etc/environment`.
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# 2. To launch IBus on user login, create an autostart entry of ibus-daemon.
if pgrep ibus-dae > /dev/null; 
then  
    echo "ibus-daemon is running" 
else 
    echo "ibus-daemon not running. auto-restarting it." 
    ibus-daemon -drxR
fi
# ----------------------------------------------------------------------
```

3. Configuratiom
# /etc/locale.gen

This can be achieved by uncommenting applicable entries in `/etc/locale.gen`, and running `locale-gen`.

```text
# file: /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
```

2.Install ibus-rime

```
sudo apt-get install ibus-rime 
sudo apt install librime-dev



*sudo

```



# restart IBus
ibus-daemon -drx
#  IBus Preferences
ibus-setup
```

## 
ls
