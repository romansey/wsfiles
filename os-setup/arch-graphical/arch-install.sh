#!/bin/bash
set -e

# Prepare mirrorlist
cat /etc/pacman.d/mirrorlist | grep --no-group-separator -A1 '^## Germany$' >/etc/pacman.d/mirrorlist.new
mv /etc/pacman.d/mirrorlist.new /etc/pacman.d/mirrorlist
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab

# Run system configuration script
cp arch-system.sh /mnt
chmod +x /mnt/arch-system.sh
arch-chroot /mnt /arch-system.sh
rm /mnt/arch-system.sh

echo "Setup complete. Please configure the boot loader now: /mnt/boot/loader"