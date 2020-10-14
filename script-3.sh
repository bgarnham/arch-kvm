#!/bin/bash

# SCRIPT 3

read -p "what username do you want?" USERNAME
${USERNAME}
echo -e "\e[1m\e[32mcreate new user 'user'\e[0m"
useradd -mg wheel ${USERNAME}

(echo -e "
\e[1m\e[33m*******************
set ${USERNAME} password
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

echo -e "\e[1m\e[32mupdate mirror list\e[0m"
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c UnitedStates -a 6 --sort rate --save /etc/pacman.d/mirrorlist

(echo -e "\e[1m\e[33m
***************************************
You have the option of installing xorg
it's required for a desktop environment
***************************************\e[0m")

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install xorg? " yn
    case $yn in
        [Yy]* ) pacman -S xorg-server xterm xorg-xinit; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done
printf "\e[0m "

(echo -e "\e[1m\e[33m
**********************************
You have the option of installing:
1) cinnamon
2) budgie
3) mate
**********************************\e[0m")

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install cinnamon?" yn
    case $yn in
        [Yy]* ) pacman -S cinnamon; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done
printf "\e[0m "

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install budgie?" yn
    case $yn in
        [Yy]* ) pacman -S budgie-desktop; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done
printf "\e[0m "

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install mate + mate apps?" yn
    case $yn in
        [Yy]* ) pacman -S mate mate-extra; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
printf "\e[0m "

(echo -e "\e[1m\e[33m
**********************************
You have the option of installing:
1) gdm
2) lightdm
**********************************\e[0m")

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install gdm or lightdm?" dm
    case $dm in
        gdm ) pacman -S gdm; enable gdm; break;;
        lightdm ) pacman -S lightdm; pacman -S lightdm-gtk-greeter; enable lightdm; break;;
        [Nn]* ) break;;
        * ) echo "Please answer gdm, lightdm or no.";;
    esac
done
printf "\e[0m "

(echo -e "\e[1m\e[33m
********************************************************************
You have the option of installing the following software collection:
firefox
gnome-terminal
gnome-control-center
kate
catfish
gnome-calculator
gnome-system-monitor
file-roller
gwenview
gimp
transmission
thunar
libreoffice
evince
parole
kodi
mpv
bleachbit
i3lock
********************************************************************\e[0m")

printf "\e[1m\e[33m"
while true; do
    read -p "do you wish to install the additional software?" yn
    case $yn in
        [Yy]* ) pacman -S firefox \
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
                        i3lock; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done
printf "\e[0m "

printf "\e[1m\e[33m"
(read -p "
***********************
 installation complete
system will now reboot
press enter to continue
***********************")
printf "\e[0m "

reboot
