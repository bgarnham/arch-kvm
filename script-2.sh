#!/bin/bash

# SCRIPT 2

echo "start ssh service"
systemctl start sshd

echo -e "\e[1m\e[32mcreate swap\e[0m"
dd if=/dev/zero of=/swapfile bs=1G count=2 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "" >> /dev/fstab
echo "/swapfile none defaults 0 0" >> /dev/fstab

echo -e "\e[1m\e[32minstall network manager, grub, reflector, etc\e[0m"
pacman -S networkmanager grub dialog reflector bash-completion man terminus-font

echo -e "\e[1m\e[32menable network manager\e[0m"
systemctl enable NetworkManager

echo -e "\e[1m\e[32mrun grub install\e[0m"
grub-install /dev/vda

echo -e "\e[1m\e[32mgenerate grub config\e[0m"
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\e[1m\e[32mset root password\e[0m"
passwd

echo -e "\e[1m\e[32muncomment locale options\e[0m"
sed -i 's/# en_US.UtF-8 UTF-8/en_US.UtF-8 UTF-8/g' /etc/locale.genfstab
sed -i 's/# en_US ISO-8859-1/en_US ISO-8859-1/g' /etc/locale.genfstab

echo -e "\e[1m\e[32mgenerate locale\e[0m"
locale-gen

echo -e "\e[1m\e[32mset locale\e[0m"
echo LANG=en_US.UTF-8 >> /etc/locale.conf

echo -e "\e[1m\e[32mset hostname\e[0m"
echo archvb >> /etc/hostname

echo -e "\e[1m\e[32mset timezone\e[0m"
ln -sf /usr/share/zoneinfo/America/Vancouver

echo -e "\e[1m\e[32msync hardware clock\e[0m"
hwclock --systohc

read -p "run 'exit', 'umount -R /mnt', 'reboot' to main system then run script 3 - press enter to continue"
