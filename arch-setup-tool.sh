#/bin/sh

echo "Setting Base System..."

    sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers;
    pacman -S mariadb plymouth --noconfirm;
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql;
    cp ./config-files/mkinitcpio.conf /etc;
    cp ./config-files/pacman.conf /etc;
    cp ./config-files/plymouthd.conf /etc/plymouth;
    cp ./config-files/nobeep.conf /etc/modprobe.d;
    pacman -Sy;
    mkinitcpio -P linux;

echo "Installing GNOME..."

    pacman -S ttf-dejavu ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family noto-fonts noto-fonts-cjk noto-fonts-emoji --noconfirm;
    pacman -S gnome aisleriot gnome-chess gnuchess gnome-mines gnome-robots gnome-sudoku quadrapassel drawing lollypop celluloid gthumb gnome-browser-connector gnome-notes endeavour vlc qt5ct kvantum ibus ibus-hangul ibus-anthy file-roller p7zip unrar unarchiver unace gnome-tweaks evolution evolution-spamassassin highlight system-config-printer gnome-shell-extension-appindicator libappindicator-gtk3 deja-dup rsync htop lm_sensors lsof strace iio-sensor-proxy gnome-tour gnome-initial-setup power-profiles-daemon firefox-ko firefox-i18n-ko libreoffice-fresh-ko libreoffice-fresh ufw gufw polari --noconfirm;
    pacman -S wine wine-mono wine-gecko winetricks samba --noconfirm;
    pacman -Rnn epiphany gnome-software gnome-music gnome-photos gnome-console totem --noconfirm;
    cp ./config-files/images/archlinux-text-logo.png /usr/share/pixmaps;
    cp ./config-files/gnome/*.gschema.override /usr/share/glib-2.0/schemas;
    glib-compile-schemas /usr/share/glib-2.0/schemas;
    mkdir /usr/share/gnome;
    mkdir /usr/share/gnome/autostart;
    cp ./config-files/gnome/libcanberra-login-sound.desktop /usr/share/gnome/autostart;
    echo -e "\nGTK_IM_MODULE=ibus\nQT_IM_MODULE=ibus\nXMODIFIERS=@im=ibus\nQT_QPA_PLATFORMTHEME=qt5ct\nMOZ_ENABLE_WAYLAND=1\n"  >> /etc/environment;

echo "Setting Up Chaotic-AUR..."

    pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com;
    pacman-key --lsign-key 3056513887B78AEB;
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm;
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n"  >> /etc/pacman.conf;
    pacman -Sy;

echo "Installing Additional Packages..."

    pacman -S gnome-shell-extension-gsconnect gnome-shell-extension-blur-my-shell gnome-shell-extension-arch-update adw-gtk3 ttf-hack-nerd ttf-sourcecodepro-nerd pamac-nosnap morewaita bibata-cursor-theme rnote gnome-terminal-transparency yaru-sound-theme aic94xx-firmware wd719x-firmware upd72020x-fw gradience gdm-settings --noconfirm;

echo "Setting Bootloader..."

    cp ./config-files/bootloader/grub /etc/default;
    cp ./config-files/bootloader/10_linux /etc/grub.d;
    chmod 644 /etc/grub.d/10_linux;
    chmod +x /etc/grub.d/10_linux;
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="arch";
    mkdir /boot/efi/EFI/Boot;
    cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/EFI/Boot/bootx64.efi;
    grub-mkconfig -o /boot/grub/grub.cfg;

echo "Applying Ubuntu CJK Font Rendering..."

    ./config-files/font-rendering/font-config.sh;

echo "Enabling services..."

    systemctl enable cups;
    systemctl enable NetworkManager;
    systemctl enable bluetooth;
    systemctl enable gdm;
    systemctl enable mysql;
    systemctl enable ufw;

echo "Completed!"
