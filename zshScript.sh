#!/bin/bash

## zsh - Install and configuration script
## by: Vinicius Tartari - tested in Debian 10 (buster)

# Store name of current directory
DIRECTORY=$(cd `dirname $0` && pwd)

echo -e "\033[01;32mzsh - Install and configuration script - by Vinicius Tartari\033[0m"
# --------------------------------------------
echo -e "\033[01;33mInstall zsh\033[0m"
sudo apt install zsh -y

echo -e "\033[01;33mOh My Zsh - preconfiguration to Zsh \033[0m"
sudo curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh

echo -e "\033[01;33mChange user default terminal to zsh\033[0m"
sudo usermod --shell $(which zsh) $USER
# --------------------------------------------
echo -e "\033[01;32mAdding functional resources\033[0m"

echo -e "\033[01;33mzsh-syntax-highlighting\033[0m"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\033[01;33mzsh-autosuggestions\033[0m"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo -e "\033[01;33mfzf\033[0m"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# --------------------------------------------
echo -e "\033[01;32mAdding visual resources\033[0m"

echo -e "\033[01;33mDownloading and installing font\033[0m"
cd ~/Downloads
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip
if [ ! -d ~/.fonts ]; then
  mkdir ~/.fonts
fi
cd ~/.fonts
unzip ~/Downloads/Hack.zip
rm ~/Downloads/Hack.zip

echo -e "\033[01;33mChanging terminal font\033[0m"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_system_font --type=boolean false
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Hack Nerd Font Mono Regular 11"

echo -e "\033[01;33mAdding Power Level 10K Theme\033[0m"
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# --------------------------------------------
echo -e "\033[01;32mUpdating config file (.zshrc)\033[0m"
# Removing possible .zshrc file
rm ~/.zshrc
cd $DIRECTORY
cp zshrc-configfile.txt ~/.zshrc

echo -e "\033[01;32mZSH configured. Restart to start to use!\033[0m"

echo -e "\033[01;33mRestart now? (y/n) \033[0m" && read x && [[ "$x" == "y" ]] && /sbin/reboot

# VERDE - echo -e "\033[01;32m  \033[0m"
# AMARELO - echo -e "\033[01;33m \033[0m"
