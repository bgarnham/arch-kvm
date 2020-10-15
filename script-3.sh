#!/bin/bash

# SCRIPT 3

RESET="\e[0m"
BOLD="\e[1m"
GREEN="\e[32m"
YELLOW="\e[33m"

read -p "what username do you want?" USERNAME

echo -e "${BOLD}${GREEN}create new user ${USERNAME}${RESET}"
useradd -mg wheel ${USERNAME}

(echo -e "${BOLD}${YELLOW}
************************
set ${USERNAME} password
************************${RESET}")
passwd user

echo -e "${BOLD}${GREEN}add ${USERNAME} to sudoers${RESET}"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/'

echo -e "${BOLD}${GREEN}update mirror list${RESET}"
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c UnitedStates -a 6 --sort rate --save /etc/pacman.d/mirrorlist

(echo -e "${BOLD}${YELLOW}
***************************************
You have the option of installing xorg
it's required for a desktop environment
***************************************${RESET}")

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install xorg? " yn
    printf "${RESET}"
    case $yn in
        [Yy]* ) pacman -S xorg-server xterm xorg-xinit; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done

(echo -e "${BOLD}${YELLOW}
**********************************
You have the option of installing:
1) cinnamon
2) budgie
3) mate
**********************************${RESET}")

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install cinnamon? " yn
    printf "${RESET}"
    case $yn in
        [Yy]* ) pacman -S cinnamon; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install budgie? " yn
    printf "${RESET}"
    case $yn in
        [Yy]* ) pacman -S budgie-desktop; break;;
        [Nn]* ) break;;
        * ) echo "please answer yes or no.";;
    esac
done

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install mate + mate apps? " yn
    printf "${RESET}"
    case $yn in
        [Yy]* ) pacman -S mate mate-extra; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

(echo -e "${BOLD}${YELLOW}
**********************************
You have the option of installing:
1) gdm
2) lightdm
**********************************${RESET}")

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install gdm or lightdm? " dm
    printf "${RESET}"
    case $dm in
        gdm ) pacman -S gdm; systemctl enable gdm.service; break;;
        lightdm ) pacman -S lightdm; pacman -S lightdm-gtk-greeter; systemctl enable lightdm.service; break;;
        [Nn]* ) break;;
        * ) echo "Please answer gdm, lightdm or no.";;
    esac
done

(echo -e "${BOLD}${YELLOW}
********************************************************************
You have the option of installing the following software collection:
bleachbit
catfish
evince
file-roller
firefox
gimp
gnome-calculator
gnome-control-center
gnome-system-monitor
gnome-terminal
gwenview
i3lock
kate
kodi
libreoffice
mpv
parole
thunar
transmission
********************************************************************${RESET}")

while true; do
    printf "${BOLD}${YELLOW}"
    read -p "do you wish to install the additional software? " yn
    printf "${RESET}"
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

printf "${BOLD}${YELLOW}"
(read -p "
***********************
 installation complete
system will now reboot
press enter to continue
***********************")
printf "${RESET}"

reboot
