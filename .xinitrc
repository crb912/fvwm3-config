#!/bin/bash
# https://wiki.archlinux.org/title/Xinit


#----------------------------- boot on tty 1 ---------------------------

# See: --> https://askubuntu.com/a/825142
# 0.   sudo gedit /etc/default/grub
#      GRUB_CMDLINE_LINUX_DEFAULT="text"
#      sudo update-grub

# 1. Tell systemd to not load the desktop with :
#      sudo systemctl enable multi-user.target --force
#      sudo systemctl set-default multi-user.target      

# 2. disable startx && set graphical:
#      sudo systemctl enable graphical.target --force
#      sudo systemctl set-default graphical.target

# ----------------------------------------------------------------------

# https://wiki.archlinux.org/title/Xinit
# https://gist.github.com/addy-dclxvi/a95d4ae729c21e4d14840cb07abdda6f

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
        for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

# ----------------------- Set DBus -------------------------------------

# If you unset DBUS_SESSION_BUS_ADDRESS, 
# it will cause programs relying on session bus to stop working.
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; 
then
    echo "dbus session not running. auto-restarting it." 
    eval "$(dbus-launch --sh-syntax --exit-with-session)" 
fi

# See: https://bugs.archlinux.org/task/46374
dbus-update-activation-environment --all

# ----------------------------------------------------------------------

# https://unix.stackexchange.com/questions/230238/x-applications-warn-couldnt-connect-to-accessibility-bus-on-stderr

export NO_AT_BRIDGE=1

# ----------------------- configure My dual monitor --------------------
# You should NOT do this!
# just for my case: dual monitor. 

xrandr --output HDMI-0 --primary --left-of DVI-I-1

# --------------------- input method ----------------------------------

# NOT necessary for you.
# For my case, I use Chinese input method ibus-rime.
# https://wiki.archlinux.org/title/IBus

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

# run `ibus-setup`, set my input-method switching by  <Shift> 

# -------------------------- Locale ------------------------------------

# set the system locale
export LANG=en_US.utf8
export LANGUAGE=en_US.utf8
export LANG=en_US.utf8
export LC_COLLATE=C
export LC_ADDRESS=en_US.utf8
export LC_ADDRESS=en_US.utf8
export LC_CTYPE=en_US.utf8
export LC_IDENTIFICATION=en_US.utf8
export LC_MEASUREMENT=id_ID.utf8
export LC_MESSAGES=en_US.utf8
export LC_MONETARY=id_ID.utf8
export LC_NAME=en_US.utf8
export LC_NUMERIC=id_ID.utf8
export LC_PAPER=id_ID.utf8
export LC_TELEPHONE=id_ID.utf8
export LC_TIME=en_US.utf8

# LC_ALL: troubleshooting. 
# The locale set for this variable will always override LANG and all
# the other LC_* variables, whether they are set or not.
export LC_ALL=en_US.utf8

# --------------------------- mount ------------------------------------

# You should NOT do this!

if [ -d "/home/bing/OneDrive" ] 
then
    echo "OneDrive has mounted" 
else
    echo "start to mount OneDrive."
    #sudo mount 192.168.1.6:/volume1/OneDrive /home/bing/OneDrive
fi

if [ -d "/home/bing/Media" ] 
then
    echo "OneDrive has mounted" 
else
    echo "start to mount Media."
    #sudo mount 192.168.1.6:/volume2/Media /home/bing/Media
fi

# ----------------------- Gnome Keyring -------------------------------

# See:  https://wiki.archlinux.org/title/GNOME/Keyring
# DEBUG: ps aux | grep gnome-keyring-daemon
# DEBUG: journalctl -b | egrep 'keyring|seahorse|secret'


# NOTE：The call to gnome-keyring-daemon in xinitrc intializes it and 
# puts the proper environment variables into the X session. 
# It does not start another instance.
# It must happen after the dbus-launch line.

if pgrep gnome-keyring-daemon > /dev/null; 
then  
    echo "gnome-keyring-daemon is running" 
else 
    echo "gnome-keyring-daemon not running. auto-restarting it." 
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK
fi

dbus-update-activation-environment --systemd DISPLAY

# ----------------------- launch yours WM or Desktop Env ---------------

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice. My choice is fvwm
#exec fvwm3

exec fvwm3

# ----------------------------------------------------------------------

