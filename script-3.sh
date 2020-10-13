#!/bin/bash

# SCRIPT 3

echo -e "\e[1m\e[32mcreate new user 'user'\e[0m"
useradd -mg wheel user

echo -e "\e[1m\e[32mset 'user' password\e[0m"
passwd user

read -p "sudoers file: uncomment '%wheel ALL=(ALL) ALL' - press enter to continue"

EDITOR=vim visudo

# copy script-4 and script-5 to /home/user and chown files to user

read -p "logging out. log in as 'user' and run script 5 - press enter to continue"

logout

