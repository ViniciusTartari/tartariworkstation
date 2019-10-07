#!/bin/bash

## Pos installation script
## ******* TO DEBIAN 9 *******
## By: Vinicius Tartari - Sony Vaio VPC236FMB

echo -e "\033[01;32mMy pos-installation script - Debian 9 - by Vinicius Tartari\033[01;37m" 

## ----------------------------------------------------------------------
## Removendo travas eventuais do apt ##
echo -e "\033[01;32mRemoving eventually locks from apt\033[01;37m" 
sudo rm /var/lib/dpkg/lock-frontend; sudo rm /var/cache/apt/archives/lock ;
## ----------------------------------------------------------------------
## Adicionando/Confirmando arquitetura de 32 bits ##
echo -e "\033[01;32mAdd 32 bits architecture to dpkg\033[01;37m" 
sudo dpkg --add-architecture i386 

## Add non-free to official repositories
echo -e "\033[01;32mAdd non-free to official repositories\033[01;37m" 
sudo apt-add-repository non-free

## Atualizando o repositório ##
echo -e "\033[01;32mRunning the apt update\033[01;37m" 
sudo apt update
## ----------------------------------------------------------------------

## Adicionando repositórios de terceiros e suporte a Snap ##
echo -e "\033[01;32mAdd third party repositories\033[01;37m"

## -------Lutris-------
echo -e "\033[01;32mLutris\033[01;37m"
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_9.0/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_9.0/Release.key -O- | sudo apt-key add -
## -------/Lutris------

## -------Wine-------
echo -e "\033[01;32mWine\033[01;37m"
wget -nc https://dl.winehq.org/wine-builds/winehq.key 
sudo apt-key add winehq.key 
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/debian/ stretch main' 
## -------/Wine------

## -------VirtualBox-------
echo -e "\033[01;32mVirtual Box\033[01;37m"
echo "deb https://download.virtualbox.org/virtualbox/debian stretch contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
## -------/VirtualBox------

## -------Typora-------
echo -e "\033[01;32mTypora\033[01;37m"
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
## -------/Typora------

## -------NodeJS-------
echo -e "\033[01;32mNodeJS\033[01;37m"
sudo curl -sL https://deb.nodesource.com/setup_10.x | bash -
## -------/NodeJS------

## -------Yarn--------
echo -e "\033[01;32mYarn\033[01;37m"
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
## -------/Yarn-------

## -------Docker-------
echo -e "\033[01;32mDocker\033[01;37m"
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
## -------/Docker------

## Atualizando o repositório depois da adição de novos repositórios ##
echo -e "\033[01;32mRunning apt update after additions\033[01;37m"
sudo apt update

## ----------------------------------------------------------------------

## Download e instalaçao de programas externos ##
echo -e "\033[01;32mCreating programs folder in Downloads\033[01;37m"
mkdir /home/$USER/Downloads/programs
cd /home/$USER/Downloads/programs

echo -e "\033[01;32mDownloading external programs\033[01;37m"
## Franz
echo -e "\033[01;32mFranz\033[01;37m"
wget -c https://github.com/meetfranz/franz/releases/download/v5.3.3/franz_5.3.3_amd64.deb

## MEGAsync
echo -e "\033[01;32mMEGAsync\033[01;37m"
wget -c https://mega.nz/linux/MEGAsync/Debian_9.0/amd64/megasync-Debian_9.0_amd64.deb

## Steam
echo -e "\033[01;32mSteam\033[01;37m"
wget -c http://repo.steampowered.com/steam/archive/precise/steam_latest.deb

## Team Viewer
echo -e "\033[01;32mTeam Viewer\033[01;37m"
wget -c https://dl.teamviewer.com/download/linux/version_14x/teamviewer_14.6.2452_amd64.deb

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "\033[01;32mInstalling external programs\033[01;37m"
sudo dpkg -i *.deb
echo -e "\033[01;32mRunning apt install -f to dependencies corrections\033[01;37m"
sudo apt install -f -y

## ----------------------------------------------------------------------

## Programas do repositório APT##
echo -e "\033[01;32mInstalling programs via APT\033[01;37m"

## Snap
echo -e "\033[01;32mSnap\033[01;37m"
sudo apt install snapd -y

## Nvidia
echo -e "\033[01;32mNvidia detect and driver\033[01;37m"
sudo apt install nvidia-detect -y
nvidia-detect
sudo apt install nvidia-driver -y

## Lutris
echo -e "\033[01;32mLutris\033[01;37m"
sudo apt install lutris -y
sudo apt install lutris libvulkan1 libvulkan1:i386 -y

# Wine
echo -e "\033[01;32mWine and dependencies\033[01;37m"
sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

# Docker
echo -e "\033[01;32mDocker and dependencies\033[01;37m"
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Programas
echo -e "\033[01;32mGcc, git, build-essential and others\033[01;37m"
sudo apt install gcc git build-essential filezilla gimp gparted htop inkscape kate virtualbox-6.0 typora vlc nodejs yarn libavcodec-extra -y

# To gnome extensions
echo -e "\033[01;32mDependencies to gnome-extensions\033[01;37m"
sudo apt install gir1.2-gtop-2.0 lm-sensors -y

# Gnome extensions
echo -e "\033[01;32mGnome-extensions\033[01;37m"
sudo apt install gnome-shell-extension-caffeine gnome-shell-extension-dashtodock gnome-shell-extension-pixelsaver -y

# Vitals - gnome extension
echo -e "\033[01;32mGone-extensions-vitals\033[01;37m"
mkdir -p ~/.local/share/gnome-shell/extensions
git clone https://github.com/corecoding/Vitals.git ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com

## ----------------------------------------------------------------------

## Instalando pacotes Snap ##
echo -e "\033[01;32mInstalling snap packages\033[01;37m"
echo -e "\033[01;32mArduino, insomnia, audacity, discord, robo3t, go, vscode, heroku, android-studio\033[01;37m"
echo -e "\033[01;32mRedis, node-red, spotify, photogimp, instagraph and snap-store\033[01;37m"
sudo snap install arduino-mhall119
sudo snap install insomnia
sudo snap install audacity
sudo snap install discord
sudo snap install robo3t-snap
sudo snap install go --classic
sudo snap install code --classic
sudo snap install heroku --classic
sudo snap install android-studio --classic
sudo snap install redis-desktop-manager
sudo snap install node-red
sudo snap install snap-store
sudo snap install spotify
sudo snap install photogimp
sudo snap install instagraph

## ----------------------------------------------------------------------

## Instalando DBs com docker
echo -e "\033[01;32mInstalling mongoDB and MySQL on Docker\033[01;37m"
sudo docker pull mongo
sudo docker pull mysql

## ----------------------------------------------------------------------

## Atualizando npm
echo -e "\033[01;32mUpdating npm\033[01;37m"
sudo npm i -g npm

## Finalização, atualização e limpeza##
echo -e "\033[01;32mFinish the installations\033[01;37m"
echo -e "\033[01;32mUpdating and cleaning system\033[01;37m"
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean 
sudo apt autoremove -y

echo -e "\033[01;32;40mTHE END!\033[01;37m"