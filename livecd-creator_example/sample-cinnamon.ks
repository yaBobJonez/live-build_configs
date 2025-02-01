# (!) Live system
%include fedora-live-base.ks
%include fedora-live-cinnamon.ks

# Use graphical installer
graphical

# Red Hat's EULA
eula --agreed

# Localization
keyboard --xlayouts=us,ru,ua --switch='grp:ctrl_shift_toggle'
lang ru_RU.UTF-8 --addsupport=en_US.UTF-8,uk_UA.UTF-8
timezone Europe/Kyiv

# Live disk
part / --size=16384

# RPMFusion repos
repo --name="rpmfusion-free"  --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name="rpmfusion-free-updates"  --baseurl=http://download1.rpmfusion.org/free/fedora/updates/$releasever/$basearch/
repo --name="rpmfusion-nonfree"  --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os/
repo --name="rpmfusion-nonfree-updates"  --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/$releasever/$basearch/

%packages

# Core desktop
@^cinnamon-desktop-environment
-@dial-up
-@input-methods
@guest-desktop-agents
-@desktop-accessilibity

# Unwanted dependencies
-NetworkManager-wwan
-NetworkManager-adsl
-NetworkManager-iodine-gnome
-NetworkManager-l2tp-gnome
-NetworkManager-libreswan-gnome
-NetworkManager-openconnect-gnome
-NetworkManager-openvpn-gnome
-NetworkManager-pptp-gnome
-NetworkManager-vpnc-gnome
-tmux-powerline
-xawtv

# Not needed
-NetworkManager-bluetooth
-blueman
-dnfdragora-updater
-imsettings-gsettings
-powerline
-redshift-gtk
-vim-powerline
-xfburn
-yelp

# Default software
-firefox
-hexchat
-pidgin
-mpv
-shotwell
-thunderbird
-transmission
-eom

# Additional software
gnome-software
gnome-connections
vlc
gthumb
pinta
flatseal
fuse
unrar

%end

# (!) REQUIRED to resolve hostnames
network --device=link --nameserver=8.8.8.8 --activate

# Systemd services
services --disabled=flatpak-add-fedora-repos

# Copy configuration files and hooks
%post --nochroot --erroronfail
cp -rv root/. "$INSTALL_ROOT/"
%end

# Run hooks in a temporary container to:
# install Flatpaks (doesn't work in normal chroot)
# install Microsoft fonts (doesn't download correctly in chroot)
%post --nochroot --erroronfail
podman run --rm --privileged --rootfs "$INSTALL_ROOT" /root/.hooks.sh
%end

%post --log /root/ks-config.log

# Change default configuration
base64 -d << EOF > sample-logo.png
iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJN
AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABNVBMVEXeLhbeLhbeLhbeLhbe
LhbeLhbeLBXeKxTeLRXhRirmbUrphF3og1zlakjhRCjfOiDphl/xypf04Kn046z036jxx5Tof1nf
Nx3soXX04ar046vrmW7piGH04qrofljhSCzxzJnxxZPgQibmb0z03qflZUPphV704qvnelXeKxPo
gVvndlLkYkHz3Kbz2KPjWTreLBTfOR/utIX05Kztq37fNhzeLRbkXj7y05/yz5vjVjfneVTvtYXt
rH7mck703aflaEbhSS3y0JzxyZbhQifwvo3vtYbfNRzfNRvvtof156/urH7eMRneLxfne1XusIHu
r4Dur4Hnc0/gOiPhQyzhQivgOiTvnJH63tr52tbwoJXeMBjoaln86+j////87Orobl3lWEXukYTu
koXlWkfeLhfeLBN9xMFIAAAABXRSTlMVkvD77w8bgyMAAAABYktHRF4E1mG7AAAACXBIWXMAAAsT
AAALEwEAmpwYAAAAB3RJTUUH5AkIDigNoNdGtwAAASVJREFUOMuF02dXwjAUBuAUuE1UFG1cqeJE
sc5qxL23KIqjCg7c/P+fYA5WKCdJ+37tc25ubnoRMmKgTcxAyIhDSOIGSkBoEggi0gxMLEK0gEBL
a1uyvYMQNSCpzi6L0u6e3j6iAiTVz2wmQq2BgAhUGEyzv6StIQUwh0dsHzA6OkYkgMctVk9mAstg
kjZAdsqRwXQQzCjA7Fzj+/yCKwGyuMT/AV/OrcjXdFfXsn6B9Y16gaZRJ/17ZDaVkxSj3Kr1Sbdz
agB4p1Zidw+DGpj7B6IL+/BI85rijGNxBj851f0PcHae5zx/cakFhavrYvHmFrQA7u49z3vQg8Jj
qVwuPT1rgfvyWqm8vbv6I+Dj8+v7J6QHqDpOFcKAnOjVi1zeqPX/BZlVNF1iAPNcAAAAJXRFWHRk
YXRlOmNyZWF0ZQAyMDIwLTA5LTA4VDE0OjQwOjEzKzAyOjAwG+hOigAAACV0RVh0ZGF0ZTptb2Rp
ZnkAMjAyMC0wOS0wOFQxNDo0MDoxMyswMjowMGq19jYAAABXelRYdFJhdyBwcm9maWxlIHR5cGUg
aXB0YwAAeJzj8gwIcVYoKMpPy8xJ5VIAAyMLLmMLEyMTS5MUAxMgRIA0w2QDI7NUIMvY1MjEzMQc
xAfLgEigSi4A6hcRdPJCNZUAAAAASUVORK5CYII=
EOF
xdg-icon-resource install --size 32 sample-logo.png
rm sample-logo.png

cat << EOF > /etc/dconf/db/local.d/sample
[org/cinnamon/desktop/interface]
keyboard-layout-show-flags=false
keyboard-layout-use-upper=true
gtk-theme='Mint-Y-Aqua'
[org/cinnamon/desktop/keybindings/media-keys]
area-screenshot=['<Control>Print']
area-screenshot-clip=['Print']
screenshot=['<Primary><Super>Print']
screenshot-clip=['<Super>Print']
window-screenshot=['<Control><Alt>Print']
window-screenshot-clip=['<Alt>Print']
[org/cinnamon]
favorite-apps=['org.gnome.Calculator.desktop', 'com.google.Chrome.desktop:flatpak', 'nemo.desktop', 'org.remmina.Remmina.desktop', 'org.gnome.Software.desktop']
panels-height=['1:40']
[org/cinnamon/theme]
name='Mint-Y-Dark-Aqua'
[org/gnome/libgnomekbd/keyboard]
layouts=['us','ru','ua']
options=['grp\tgrp:ctrl_shift_toggle']
EOF
dconf update

%end
