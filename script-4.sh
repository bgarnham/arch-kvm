#!/bin/bash

# SCRIPT 4

echo -e "\e[1m\e[32mupdate mirror list\e[0m"
sudo pacman -S reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c UnitedStates -a 6 --sort rate --save /etc/pacman.d/mirrorlist

echo -e "\e[1m\e[32minstall basic X\e[0m"
sudo pacman -S xorg-server xterm xorg-xinit

echo -e "\e[1m\e[32minstall cinnamon and budgie desktops\e[0m"
sudo pacman -S cinnamon budgie-desktop

echo -e "\e[1m\e[32minstall gdm\e[0m"
sudo pacman -S gdm

echo -e "\e[1m\e[32menable gdm\e[0m"
sudo systemctl enable gdm

read -p "run script 5 after reboot to install apps - press enter to continue"

sudo reboot

