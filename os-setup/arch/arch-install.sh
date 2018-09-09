#!/bin/bash
set -e

# Settings
export HOSTNAME="arch-workstation"
export USERNAME="user"
export MIRROR_COUNTRY="Germany"
export TIMEZONE="Europe/Berlin"
export GEN_LOCALES="en_US.UTF-8 de_DE.UTF-8"
export USE_LOCALE="en_US.UTF-8"
export USE_KEYMAP="de-latin1"

# Prepare mirrorlist
cat /etc/pacman.d/mirrorlist | grep --no-group-separator -A1 "^## $MIRROR_COUNTRY$" >/etc/pacman.d/mirrorlist.new
mv /etc/pacman.d/mirrorlist.new /etc/pacman.d/mirrorlist
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab

# Run system configuration script
cp arch-system.sh /mnt
chmod +x /mnt/arch-system.sh
arch-chroot /mnt /arch-system.sh
rm /mnt/arch-system.sh

echo "Setup complete. Please configure the boot loader now: /mnt/boot/loader"