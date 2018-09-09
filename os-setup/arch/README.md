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

   To connect via WIFI, use:
   ```sh
   ip link # memorize wifi adapter
   wpa_supplicant -B -i WIFI_ADAPTER -c <(wpa_passphrase SSID PASSWORD)
   dhcpcd
   ```

2. Get and run install scripts:
   ```sh
   wget "https://raw.githubusercontent.com/Urlaubsgimpel/wsfiles/master/os-setup/arch/arch-install.sh"
   wget "https://raw.githubusercontent.com/Urlaubsgimpel/wsfiles/master/os-setup/arch/arch-system.sh"
   vim arch-install.sh # edit settings of the install script
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
   Then add boot entries at `/mnt/boot/loader/entries`. Example arch entry:
   ```
   title   Arch Linux
   linux   /vmlinuz-linux
   initrd  /intel-ucode.img
   initrd  /initramfs-linux.img
   options root=PARTUUID=ID rw
   ```
   Substitute ID with PARTUUID from before. Skip intel-ucode if no Intel
   machine.

   Edit `/mnt/boot/loader/loader.conf`:
   ```
   timeout 5
   default arch
   ```
   Comment out timeout line if no dual boot setup.

5. Reboot and login with normal user

6. Checkout workstation files and execute user setup
   ```sh
   git clone --recurse-submodules git@github.com:Urlaubsgimpel/wsfiles.git
   ./wsfiles/os-setup/arch/arch-user.sh
   ```