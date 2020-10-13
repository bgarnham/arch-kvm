#!/bin/bash

# SCRIPT 4

echo -e "\e[1m\e[32minstall apps\e[0m"
sudo pacman -S firefox \
                gnome-terminal \
                gnome-control-center \
                kate \
                catfish \
                gnome-calculator \
                gnome-system-monitor \
                file-roller \
                gwenview \
                gimp \
                transmission-gtk \
                thunar \
                libreoffice-fresh \
                evince \
                parole \
                kodi \
                mpv \
                bleachbit \
                i3lock

printf "\e[1m\e[33m"
(read -p "
************************************************
 installation complete
press enter to continue
************************************************")
printf "\e[0m "
