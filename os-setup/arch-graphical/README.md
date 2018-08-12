# Graphical Arch Installation

1. Follow install guide until partitions are mounted at /mnt and /mnt/boot:
   https://wiki.archlinux.org/index.php/installation_guide
   ```sh
   loadkeys de-latin1
   timedatectl set-ntp true
   # (format disks)
   fdisk /dev/xxx
   # format efi
   mkfs.vfat -F 32 /dev/xxxy
   # format root
   mkfs.ext4 /dev/xxxy
   # mount root
   mount /dev/xxxy /mnt
   # mount efi
   mkdir /mnt/boot
   mount /dev/xxxy /mnt/boot
   # enable swap (if created)
   mkswap /dev/xxxy
   swapon /dev/xxxy
   ```

2. Get and run install scripts:
   ```sh
   wget "https://git.urlaubsgimpel.de/roman/workstation-files/raw/branch/master/os-setup/arch-graphical/arch-install.sh"
   wget "https://git.urlaubsgimpel.de/roman/workstation-files/raw/branch/master/os-setup/arch-graphical/arch-system.sh"
   chmod +x *.sh
   ./arch-install.sh
   ```

3. Install intel-ucode if on Intel machine
   ```sh
   arch-chroot /mnt
   pacman -S intel-ucode
   exit
   ```

4. Configure systemd-boot
   (see: https://wiki.archlinux.org/index.php/Systemd-boot)
   ```sh
   # Get arch partition UUID
   blkid -s PARTUUID -o value /dev/xxxy
   ```
   Then add boot entries at `/mnt/boot/loader/entries`. Finally, set
   default entry in `/mnt/boot/loader/loader.conf`. Example arch entry:
   ```
   title   Arch Linux
   linux   /vmlinuz-linux
   initrd  /intel-ucode.img
   initrd  /initramfs-linux.img
   options root=PARTUUID=ID rw
   ```
   Substitute ID with PARTUUID from before. Skip intel-ucode if no Intel
   machine.

5. Reboot and login with normal user

6. Checkout workstation files and execute user setup
   ```sh
   git clone --recurse-submodules git@git.urlaubsgimpel.de:roman/workstation-files.git ~/workstation-files
   ./workstation-files/os-setup/arch-graphical/arch-user.sh
   ```