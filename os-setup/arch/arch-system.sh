#!/bin/bash
set -e

ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
hwclock --systohc
for locale in $GEN_LOCALES; do
    sed -r -i "s/^#($locale.*)$/\1/" /etc/locale.gen
done
locale-gen 
echo "LANG=$USE_LOCALE" >/etc/locale.conf
echo "KEYMAP=$USE_KEYMAP" >/etc/vconsole.conf
echo "$HOSTNAME" >/etc/hostname
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1 localhost" >>/etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >>/etc/hosts

# Official packages
pacman -Sy --noconfirm \
    base-devel networkmanager ntfs-3g gdm gnome seahorse zsh vim htop \
    go jdk10-openjdk python python2 python-pip python2-pip git \
    docker docker-compose virtualbox \
    virtualbox-host-modules-arch virtualbox-guest-iso \
    keepassxc owncloud-client ttf-dejavu noto-fonts-emoji powerline-fonts

# Enable services
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable docker

# Kernel modules
echo 'vboxdrv' >>/etc/modules-load.d/modules.conf

# Package configuration
sed -r -i 's/^# (%sudo.*)$/\1/' /etc/sudoers
sed -r -i 's/^#(WaylandEnable.*)$/\1/' /etc/gdm/custom.conf

# Boot loader
bootctl --path=/boot install

# User creation and password settings
groupadd sudo
useradd -m -G sudo,vboxusers,docker "$USERNAME"
echo "Please set root password:"
passwd
echo "Please set user password:"
passwd "$USERNAME"