#!/bin/bash

# SCRIPT 3

echo -e "\e[1m\e[32mcreate new user 'user'\e[0m"
useradd -mg wheel user

(echo -e "
\e[1m\e[33m*******************
set 'user' password
*******************\e[0m")
passwd user

printf "\e[1m\e[33m"
(read -p "
*****************************************
           now opening visudo
uncomment '%wheel ALL=(ALL) ALL' and save
         press enter to continue
*****************************************")
printf "\e[0m "

EDITOR=vim visudo

echo "\e[1m\e[32mcopy script-4.sh to /home/user and chown files to user\e[0m"
cp /root/arch-kvm-main/script-4.sh /home/user/
chown user /home/user/script-4.sh

echo -e "\e[1m\e[32mupdate mirror list\e[0m"
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c UnitedStates -a 6 --sort rate --save /etc/pacman.d/mirrorlist

echo -e "\e[1m\e[32minstall basic X\e[0m"
pacman -S xorg-server xterm xorg-xinit

echo -e "\e[1m\e[32minstall cinnamon and budgie desktops\e[0m"
pacman -S cinnamon budgie-desktop

echo -e "\e[1m\e[32minstall gdm\e[0m"
pacman -S gdm

echo -e "\e[1m\e[32menable gdm\e[0m"
systemctl enable gdm

printf "\e[1m\e[33m"
(read -p "
***************************************************************
run /home/user/script-4.sh as user after reboot to install apps
                    press enter to continue
***************************************************************")
printf "\e[0m "

reboot
