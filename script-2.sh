#!/bin/bash

# SCRIPT 2

RESET="\e[0m"
BOLD="\e[1m"
GREEN="\e[32m"
YELLOW="\e[33m"

echo -e "${BOLD}${GREEN}display filesystem${RESET}"
lsblk

printf "${BOLD}${YELLOW}enter device name to install to (vda, sda, hda):${RESET} "
read DEVICE

echo -e "${BOLD}${YELLOW}start ssh service${RESET}"
systemctl enable sshd.service

echo -e "${BOLD}${YELLOW}adding 'PermitRootLogin yes' to /etc/ssh/sshd_config${RESET}"
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

echo -e "${BOLD}${GREEN}create swap${RESET}"
dd if=/dev/zero of=/swapfile bs=1G count=2 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "" >> /dev/fstab
echo "/swapfile none defaults 0 0" >> /dev/fstab

echo -e "${BOLD}${GREEN}install network manager, grub, reflector, etc${RESET}"
pacman -S networkmanager grub dialog reflector bash-completion man terminus-font

echo -e "${BOLD}${GREEN}enable network manager${RESET}"
systemctl enable NetworkManager

echo -e "${BOLD}${GREEN}run grub install${RESET}"
grub-install /dev/${DEVICE}

echo -e "${BOLD}${GREEN}generate grub config${RESET}"
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "${BOLD}${GREEN}set root password${RESET}"
passwd

echo -e "${BOLD}${GREEN}uncomment locale options${RESET}"
sed -i 's/# en_US.UtF-8 UTF-8/en_US.UtF-8 UTF-8/g' /etc/locale.genfstab
sed -i 's/# en_US ISO-8859-1/en_US ISO-8859-1/g' /etc/locale.genfstab

echo -e "${BOLD}${GREEN}generate locale${RESET}"
locale-gen

echo -e "${BOLD}${GREEN}set locale${RESET}"
echo LANG=en_US.UTF-8 >> /etc/locale.conf

echo -e "${BOLD}${GREEN}set hostname${RESET}"
echo archvb >> /etc/hostname

echo -e "${BOLD}${GREEN}set timezone${RESET}"
ln -sf /usr/share/zoneinfo/America/Vancouver

echo -e "${BOLD}${GREEN}sync hardware clock${RESET}"
hwclock --systohc

printf "${BOLD}${YELLOW}"
(read -p "
*************************************************************
                    run 'exit', 'reboot'
login to main system then run /root/arch-kvm-main/script-3.sh
                   press enter to continue
*************************************************************")
printf "${RESET} "
