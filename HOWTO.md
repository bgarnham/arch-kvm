# How To

### 1. Set up VM

Create a new VM in VirtualBox as follows:

* RAM: 6144M
* Disk size: 20G
* Processors: 2
* Set CDROM to first boot priority
* Set ISO File in CDROM source path
* Network source: Bridge

### 2. Boot VM from ISO

### 3. Setup Scripts

Either work directly in QEMU or use SSH:

#### Set up to use SSH

```bash
#download ssh client
pacman -Syy openssh

#start ssh service
systemctl start sshd

# set password for root
passwd

# get IP address to connect to
ip a
```

#### Working in QEMU or SSH:

```bash
# download utils to download and unzip scripts
pacman -Syy wget unzip

# download script archive
wget https://github.com/bgarnham/arch-kvm/archive/main.zip

# unzip archive
unzip main.zip

# enter scripts directory
cd arch-kvm-main

# make scripts executable
chmod +x script*

# run script 1
./script-1.sh

# change into new script directory
cd root/arch-kvm-main

# run script 2
./script-2.sh

# exit chroot
exit

# unmount /mnt
umount -R /mnt

# reboot system
reboot

#change to script directory
cd /root/arch-kvm-main

#run script-3
./script-3.sh

# after reboot, login as user and use terminal
# to execute script-4 in /home/user
./script-4.sh
```
You may want to delete "PermitRootLogin yes" from /etc/ssh/sshd_config
