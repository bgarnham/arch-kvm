* FAILED script 2 now has a systemctl start sshd, which hopefully works.... was required to manually start sshd after reboot
* TEST corrected sshd service startup in script-2
* aside from above, all seems to be working up until the optional installs. They still need to be tested
* try replacing visudo in script-3 with sed
* check the following worked correctly.
  * echo "/swapfile none defaults 0 0" >> /dev/fstab
  * sed -i 's/# en_US.UtF-8 UTF-8/en_US.UtF-8 UTF-8/g' /etc/locale.genfstab
  * sed -i 's/# en_US ISO-8859-1/en_US ISO-8859-1/g' /etc/locale.genfstab
  * echo archvb >> /etc/hostname
  * genfstab -U /mnt >> /mnt/etc/fstab
  * echo "/swapfile none defaults 0 0" >> /dev/fstab
* considering
  lsblk | grep disk | awk -F" " '{print $1}'
  OR
  lsblk | grep disk | cut -d' ' -f1
  OR
  lsblk | grep disk | grep -o '^[^ ]\+'
  when asking to select drive. this should only the name only of only 'physical' drives, or so goes my theory
* add warning and cancel option in script-1 as drive will be overwritten
