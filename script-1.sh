#!/bin/bash

# SCRIPT 1

RESET="\e[0m"
BOLD="\e[1m"
GREEN="\e[32m"
YELLOW="\e[33m"

echo -e "${BOLD}${GREEN}display filesystem${RESET}"
lsblk

printf "${BOLD}${YELLOW}enter device name to install to (vda, sda, hda):${RESET} "
read DEVICE

echo -e "${BOLD}${GREEN}use ntp time${RESET}"
timedatectl set-ntp true

echo -e "${BOLD}${GREEN}install reflector${RESET}"
pacman -Syy reflector

echo -e "${BOLD}${GREEN}update mirror list${RESET}"
reflector -c 'United States' -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

echo -e "${BOLD}${GREEN}partition drive${RESET}"
(
echo o # clear the in memory partition table
echo n # new partition
echo p # primary partition
echo 1 # partition number 1
echo   # default - start at beginning of disk
echo +128M # 128 MB boot parttion
echo n # new partition
echo p # primary partition
echo 2 # partion number 2
echo   # default, start immediately after preceding partition
echo   # default, extend partition to end of disk
echo a # make a partition bootable
echo 1 # bootable partition is partition 1
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | fdisk /dev/${DEVICE}

echo -e "${BOLD}${GREEN}make file systems${RESET}"
mkfs.ext4 /dev/${DEVICE}1
mkfs.ext4 /dev/${DEVICE}2

echo -e "${BOLD}${GREEN}mount file systems${RESET}"
mount /dev/${DEVICE}2 /mnt
mkdir /mnt/boot
mount /dev/${DEVICE}1 /mnt/boot

echo -e "${BOLD}${GREEN}install base system${RESET}"
pacstrap /mnt base base-devel linux linux-firmware vim openssh git wget unzip

echo -e "${BOLD}${GREEN}copy scripts to /root on new install${RESET}"
cp -r /root/arch-kvm-main /mnt/root/

echo -e "${BOLD}${GREEN}generate fstab${RESET}"
genfstab -U /mnt >> /mnt/etc/fstab

printf "${BOLD}${YELLOW}"
(read -p "
***********************************************
run root/arch-kvm-main/script-2.sh after chroot
           press enter to continue
***********************************************")
printf "${RESET} "

arch-chroot /mnt /bin/bash
