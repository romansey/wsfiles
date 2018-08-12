#!/bin/bash
set -e

echo -n "Machine hostname: "
read HOSTNAME
echo -n "Username: "
read USERNAME

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
sed -r -i 's/^#(en_US.UTF-8.*)$/\1/' /etc/locale.gen
sed -r -i 's/^#(de_DE.UTF-8.*)$/\1/' /etc/locale.gen
locale-gen 
echo 'LANG=en_US.UTF-8' >/etc/locale.conf
echo 'KEYMAP=de-latin1' >/etc/vconsole.conf
echo "$HOSTNAME" >/etc/hostname
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1 localhost" >>/etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >>/etc/hosts
echo "Please set root password:"
passwd

# Official packages
pacman -Sy --noconfirm \
    base-devel vim htop git zsh gdm gnome networkmanager \
    noto-fonts-emoji powerline-fonts docker docker-compose virtualbox \
    virtualbox-host-modules-arch virtualbox-guest-iso \
    keepassxc go jdk10-openjdk owncloud-client seahorse python

# Enable services
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable docker

# Kernel modules
echo 'vboxdrv' >>/etc/modules-load.d/modules.conf

# Package configuration
sed -r -i 's/^# (%sudo.*)$/\1/' /etc/sudoers

# User creation
groupadd sudo
useradd -m -G sudo,vboxusers roman
echo "Please set user password:"
passwd "$USERNAME"

# Boot loader
bootctl --path=/boot install