* Optional installs still need to be tested

* rearranged script 1, check for problems

* check swap setup for errors as it runs

* after re-install, check the following worked correctly.
  * /etc/fstab with /swapfile
  * sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
  * sed -i 's/#en_US ISO-8859-1/en_US ISO-8859-1/g' /etc/locale.gen
  * systemctl enable sshd.service
  * echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
  * ln -sf /usr/share/zoneinfo/America/Vancouver /etc/localtime
  * sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/'
  * added warning and cancel option in script-1 as drive will be overwritten
  * PASS echo LANG=en_US.UTF-8 >> /etc/locale.conf
  * PASS echo archvb >> /etc/hostname

* considering
  lsblk | grep disk | awk -F" " '{print $1}'
  OR
  lsblk | grep disk | cut -d' ' -f1
  OR
  lsblk | grep disk | grep -o '^[^ ]\+'
  when asking to select drive. this should only the name only of only 'physical' drives, or so goes my theory
