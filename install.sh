echo "Installing rchrdwllm's dotfiles..."
echo "Installing base Hyprland packages..."

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd ../

paru -S wayland kitty libdrm pixman libxkbcommon python libxml2 llvm libpng gegl mtdev xorg-xwayland qt5-wayland qt6-wayland hyprland swww waybar xdg-desktop-portal-wlr wlroots xdg-desktop-portal sddm sddm-sugar-dark
paru -S zsh polkit-kde-agent pcmanfm-qt neovim gedit swaylock-effects brightnessctl pavucontrol alsa-utils grim slurp wl-clipboard mpv python-pip rofi blueberry bluez bluez-utils ranger ts-node zsh ttf-jetbrains-mono ttf-jetbrains-mono-nerd inotify-tools thunar ark playerctl pamixer whitesur-icon-theme-git whitesur-cursor-theme-git whitesur-gtk-theme-git xdg-user-dirs nwg-look-bin python-pillow python-pywalfox pywal-discord-git mako-git viewnior gnome-keyring neofetch imagemagick wtype inter-font rofi-emoji nodejs bun-bin jdk-openjdk noto-fonts-emoji ttf-droid alsa-firmware tumbler wal-telegram-git
paru -S firefox-developer-edition discord betterdiscordctl betterdiscord-git telegram-desktop code code-features obs-studio vlc apple-music-desktop minecraft-launcher syncthing syncthing-gtk github-desktop-bin obsidian

echo "Copying .config and Wallpapers to /home directory..."

cp -r .config $HOME
cp -r Wallpapers $HOME

echo "Installing Pywal..."

# This is a comment
# TODO: Do this and that

git clone https://github.com/eylles/pywal16 ~/Downloads/Programs/pywal16
pip3 install --user ~/Downloads/Programs/pywal16 --break-system-packages

cd $HOME/.cache
mkdir wal
cd wal
touch mode
echo "dark" >|${HOME}/.cache/wal

~/.config/waybar/scripts/wallpaper.sh

echo "Enabling services SDDM and bluetooth services..."

systemctl enable sddm.service
systemctl enable bluetooth.service

echo "Successfully enabled services!"
echo "Installing and copying zsh files..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cd $HOME/Downloads/Programs/dotfiles
cp .zshrc $HOME
cp .p10k.zsh $HOME

echo "Successfully copied files!"
echo "You can now reboot your system to see changes"
echo "Would you like to reboot now? (y/n)"

read reboot

if [ $reboot = "y" ]; then
  sudo reboot
else
  echo "Alright, you can reboot later by typing 'sudo reboot'"
fi
