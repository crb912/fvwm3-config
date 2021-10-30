# FVWM on Ubuntu 21.04

> FVWM(https://www.fvwm.org/) is an ICCCM-compliant multiple virtual desktop window manager for the X Window system. It is configured by editing text-based configuration files. 

I'm tired of the endless bugs and updates of the Ubuntu's default GNOME desktop. Therefore, I switched to FWVM and no longer use GNOME desktop.

I tried FVWM for a few days, and it works very well. I haven't added some features yet, but it doesn't matter. I will continue to improve my Fvwm when I have free time. Screenshot of my desktop:

![simple desktop.png](https://i.loli.net/2021/10/30/PAlmyO9Mz4BSEZG.png)

## Part I: Install fvwm and quick start

Install the [FVWM3](https://github.com/fvwmorg/fvwm3/blob/master/dev-docs/INSTALL.md) package.

#### Build your `~/.xinitrc` file

The xinit program allows a user to manually start an Xorg display server.  

More details: https://wiki.archlinux.org/title/Xinit

My `~/.xinitrc` is [here](https://github.com/crb912/fvwm3-config/blob/main/.xinitrc).

#### Test and Try basic fvwm configuration

I use the default configuration files in `fvwm3/default-config/*` as my starting point. So, I copy those configuration files  to `~/.fvwm` directory with the following command:

```shell
# copy fvwm3/default-config github directory to ~/.fvwm.
sudo cp -r /usr/local/share/fvwm3/default-config/* ~/.fvwm

sudo chown -R someuser ~/.fvwm

sudo rm -r /usr/local/share/fvwm3/default-config
```

If your are running Ubuntu with GNONE, must logout gnome-display-manager.
Logout current Ubuntu session, and `Ctrl + Alt + F2`. Then:


```shell
# Disable Ubuntu GDM3 and
sudo service gdm3 stop

#  start X
startx
```

## Part II: Build your own fvwm3 `.config`

You can modify the default `.fvwm/config` as your first start. 
Or copy and use my `config` file directly, then make your personalized changes.

I use [nemo](https://github.com/linuxmint/nemo) as my file manager.

#### Abount `InfoStoreAdd` variavble

>
Avoiding too many environment variables leads to a lot of "pollution" within FVWM's evironment space,
we should use `InfoStoreAdd`. 

This [thread](See: https://web.archive.org/web/20060926032424/http://fvwm.lair.be/viewtopic.php?t=1505) may help you to understand.

#### Recommended reading

- https://wiki.archlinux.org/title/FVWM
- Some discuss in [ArchLabsLinux/fvwm3](https://forum.archlabslinux.com/t/fvwm3/5079/5)
- Build Taskbar: https://www.fvwm.org/Wiki/Panels/FvwmTaskBar/,  
- [Youtube: Obscure Window Manager Project - FVWM](https://www.youtube.com/watch?v=HHYXBdOgUrI)
- https://zensites.net/fvwm/guide/index.html

## Part III: Switch from Gnome to Fvwm permanently

1.Disable Gdm

```shell
sudo systemctl disable gdm3

```

2.Boot with command-line interface:

```
sudo gedit /etc/default/grub
```

comment: `#GRUB_CMDLINE_LINUX_DEFAULT="text"` and add "text". This:

```text
#GRUB_CMDLINE_LINUX_DEFAULT="quite splash"
GRUB_CMDLINE_LINUX_DEFAULT="text"

```
Then, `sudo update-grub`.


3.Tell systemd to not load the desktop with: 

```shell
sudo systemctl enable multi-user.target --force
sudo systemctl set-default multi-user.target    
```

4.AutoRun startx

add entry to `~/.bash_profile` or `~/.zprofile`
