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

echo "Installing KDE..."
    
    pacman -S ttf-dejavu ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family noto-fonts noto-fonts-cjk ttf-hack noto-fonts-emoji --noconfirm;
    pacman -S plasma plasma-wayland-session kpat knights gnuchess ksudoku kmines akregator kaccounts-provider akonadi kmail kate kontact zanshin kaddressbook korganizer kalendar kjots knotes kdepim-addons elisa gwenview digikam kdeconnect sshfs firefox firefox-i18n-ko dolphin dolphin-plugins konsole khelpcenter ktorrent kimageformats ark p7zip unrar unace unarchiver libreoffice-fresh libreoffice-fresh-ko firewalld htop lm_sensors lsof strace iio-sensor-proxy rsync kup flatpak packagekit-qt5 vlc --noconfirm;
    echo -e "\nGTK_IM_MODULE=fcitx5\nQT_IM_MODULE=fcitx5\nXMODIFIERS=@im=fcitx5\nMOZ_ENABLE_WAYLAND=1\n"  >> /etc/environment;

echo "Setting Up Chaotic-AUR..."

    pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com;
    pacman-key --lsign-key 3056513887B78AEB;
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm;
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n"  >> /etc/pacman.conf;
    pacman -Sy;
    
echo "Installing Additional Packages..."

    pacman -S ttf-hack-nerd ttf-sourcecodepro-nerd aic94xx-firmware wd719x-firmware upd72020x-fw --noconfirm;

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
    systemctl enable sddm;
    systemctl enable mysql;
    systemctl enable ufw;

echo "Completed!"
