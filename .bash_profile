# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# Add ~/.local/bin to $PATH
export PATH=$PATH:~/.local/bin

# Autostart X at login
#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] ; then
#	sleep 3 && exec startx
#fi

# -------------- Starting X11 automatically ----------------------------
# https://wiki.gentoo.org/wiki/X_without_Display_Manager
# https://wiki.archlinux.org/title/Xinit

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
