#!/bin/bash

# Flatpak apps
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub org.onlyoffice.desktopeditors
flatpak install -y --noninteractive flathub com.google.Chrome
flatpak override org.onlyoffice.desktopeditors --filesystem=home
flatpak override com.google.Chrome --filesystem=home

# Microsoft Windows fonts
dnf install -y cabextract xorg-x11-font-utils
dnf install -y https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

rm /root/.hooks.sh
