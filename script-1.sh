#!/bin/bash

# SCRIPT 1

echo -e "\e[1m\e[32muse ntp time\e[0m"
timedatectl set-ntp true

echo -e "\e[1m\e[32minstall reflector\e[0m"
pacman -Syy reflector

echo -e "\e[1m\e[32mupdate mirror list\e[0m"
reflector -c 'United States' -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

echo -e "\e[1m\e[32mpartition drive\e[0m"
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
echo 1 # bootable partition is partition 1 -- /dev/vda1
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | fdisk /dev/vda

echo -e "\e[1m\e[32mmake file systems\e[0m"
mkfs.ext4 /dev/vda1
mkfs.ext4 /dev/vda2

echo -e "\e[1m\e[32mmount file systems\e[0m"
mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot

echo -e "\e[1m\e[32minstall base system\e[0m"
pacstrap /mnt base base-devel linux linux-firmware vim openssh git wget unzip

echo -e "\e[1m\e[32mgenerate fstab\e[0m"
genfstab -U /mnt >> /mnt/etc/fstab

read -p "run script 2 after chroot - press enter to continue"

arch-chroot /mnt /bin/bash
