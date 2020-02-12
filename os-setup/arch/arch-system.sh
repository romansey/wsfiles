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

# Faster AUR builds
sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar'/" /etc/makepkg.conf

# Official packages
pacman -Sy --noconfirm \
    base-devel linux linux-firmware networkmanager ntfs-3g sddm plasma zsh vim htop \
    go jdk11-openjdk python python-pip git terminator \
    docker docker-compose virtualbox openssh \
    virtualbox-host-modules-arch virtualbox-guest-iso \
    keepassxc owncloud-client ttf-dejavu noto-fonts-emoji powerline-fonts \
    sweeper print-manager okular ksystemlog krdc kompare kleopatra kipi-plugins \
    kgpg kdf kdegraphics-thumbnailers kdenetwork-filesharing kcolorchooser \
    kcharselect kcalc gwenview filelight ffmpegthumbs dolphin dolphin-plugins ark

# Enable services
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable docker

# Kernel modules
echo 'vboxdrv' >>/etc/modules-load.d/modules.conf

# Package configuration
sed -r -i 's/^# (%sudo.*)$/\1/' /etc/sudoers

# Boot loader
bootctl --path=/boot install

# User creation and password settings
groupadd sudo
useradd -m -G sudo,vboxusers,docker "$USERNAME"
echo "Please set root password:"
passwd
echo "Please set user password:"
passwd "$USERNAME"