#!/bin/bash

# Function to install Bitwarden
#install_bitwarden() {
#    echo "Installing the latest Bitwarden Desktop version..."
#    latest_release=$(curl -s https://api.github.com/repos/bitwarden/clients/releases/latest | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4)
#    wget -O bitwarden-latest-amd64.deb $latest_release
#    sudo apt install ./bitwarden-latest-amd64.deb
#    sudo apt install -f
#    rm bitwarden-latest-amd64.deb
#}

# Function to install Brave browser
install_brave() {
    echo "Installing Brave browser..."
    sudo apt install curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser -y
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt update -y
    sudo apt install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    sudo systemctl enable docker && sudo systemctl enable containerd.service
}

# Function to install Google Chrome
install_chrome() {
    echo "Installing Google Chrome..."
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update -y
    sudo apt install google-chrome-stable -y
}

# Function to install Kisak Mesa Fresh
install_kisakmesa(){
    echo "Installing Kisak Mesa Fresh PPA..."
    sudo add-apt-repository ppa:kisak/kisak-mesa -y
    sudo apt update -y
    sudo apt upgrade -y
}

# Function to install OBS Studio
install_obstudio(){
    echo "Installing OBS Studio..."
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt update -y
    sudo apt install ffmpeg obs-studio -y
}

# Function to remove Snap Packages
remove_snaps() {
    echo "Removing Snap Packages..."
    sudo snap remove --purge desktop-security-center
    sudo snap remove --purge firefox
    sudo snap remove --purge firmware-updater
    sudo snap remove --purge gnome-42-2204
    sudo snap remove --purge gtk-common-themes
    sudo snap remove --purge prompting-client
    sudo snap remove --purge snap-store
    sudo snap remove --purge snapd-desktop-integration

    sudo snap remove --purge bare
    sudo snap remove --purge core22
    sudo snap remove --purge snapd

    # Disable Snapd service
    echo "Disabling Snap services..."
    sudo systemctl stop snapd
    sudo systemctl disable snapd
    sudo systemctl mask snapd
    
    echo "Removing Snap apt package..."
    sudo apt remove --purge snapd -y && sudo apt-mark hold snapd
    
    rm -rf ~/snap/
    sudo rm -rf /var/snap
    sudo rm -rf /var/lib/snapd
}

# Function to install Parsec
install_parsec(){
    echo "Installing Parsec..."
    wget --show-progress https://builds.parsec.app/package/parsec-linux.deb
    sudo dpkg -i parsec-linux.deb
    sudo apt install -f
}

# Function to install AnyDesk
install_anydesk(){
    echo "Installing AnyDesk..."
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
    echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
    sudo apt update -y
    sudo apt install anydesk -y
}

# Function to install Applications * (Without Snap support)

install_firefox(){
    echo "Installing Firefox (Without Snap)..."
    sudo install -d -m 0755 /etc/apt/keyrings
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
    echo ""deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main"" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
    echo "
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1" | sudo tee /etc/apt/preferences.d/mozilla
    
    sudo apt update -y
    sudo apt install firefox -y
}

install_libreoffice(){
    echo "Installing LibreOffice (Flathub)"
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.libreoffice.LibreOffice -y
}

install_thunderbird(){
    echo "Installing Thunderbird (Flathub)"
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.mozilla.Thunderbird -y
}

# Check Ubuntu version
ubuntu_version=$(lsb_release -rs)

if [ "$ubuntu_version" == "24.04" ]; then
    echo "Running on Ubuntu 24.04."
    echo "Do you want to remove Snap Support? (yes/no)"
    read remove_snap_choice
    if [ "$remove_snap_choice" == "yes" ]; then
        remove_snaps
    else
        echo "Skipping Snap removal."
    fi
elif [ "$ubuntu_version" == "24.04" ] || [ "$ubuntu_version" == "24.10" ]; then
    echo "Running on Ubuntu $ubuntu_version."
else
    echo "This script is designed for Ubuntu 24.04 or 24.10. Exiting."
    exit 1
fi

# Prompt user for each installation

#echo "Do you want to install the latest Bitwarden Desktop version? (yes/no)"
#read install_bitwarden_choice
#if [ "$install_bitwarden_choice" == "yes" ]; then
#    install_bitwarden
#else
#    echo "Skipping Bitwarden installation."
#fi

echo "Do you want to install Brave browser? (yes/no)"
read install_brave_choice
if [ "$install_brave_choice" == "yes" ]; then
    install_brave
else
    echo "Skipping Brave browser installation."
fi

echo "Do you want to install Docker? (yes/no)"
read install_docker_choice
if [ "$install_docker_choice" == "yes" ]; then
    install_docker
else
    echo "Skipping Docker installation."
fi

echo "Do you want to install Google Chrome? (yes/no)"
read install_chrome_choice
if [ "$install_chrome_choice" == "yes" ]; then
    install_chrome
else
    echo "Skipping Google Chrome installation."
fi

echo "Do you want to install Kisak Mesa Fresh? (yes/no)"
read install_kisakmesa_choice
if [ "$install_kisakmesa_choice" == "yes" ]; then
    install_kisakmesa
else
    echo "Skipping Kisak Mesa Fresh installation."
fi

echo "Do you want to install OBS Studio? (yes/no)"
read install_obstudio_choice
if [ "$install_obstudio_choice" == "yes" ]; then
    install_obstudio
else
    echo "Skipping OBS Studio installation."
fi

echo "Do you want to install Parsec? (yes/no)"
read install_parsec_choice
if [ "$install_parsec_choice" == "yes" ]; then
    install_parsec
else
    echo "Skipping Parsec installation."
fi

echo "Do you want to install AnyDesk? (yes/no)"
read install_anydesk_choice
if [ "$install_anydesk_choice" == "yes" ]; then
    install_anydesk
else
    echo "Skipping AnyDesk installation."
fi

# Snap removal if running on Ubuntu 24.04 and 24.10
if [ "$ubuntu_version" == "24.04" ] || [ "$ubuntu_version" == "24.10" ]; then
    echo "Do you want to remove Snap packages support? (yes/no)"
    read remove_snap_choice
    if [ "$remove_snap_choice" == "yes" ]; then
        remove_snaps
    else
        echo "Skipping Snap packages removal."
    fi
fi

# Firefox installation without Snap Support
echo "Do you want to install Firefox? (yes/no)"
read install_firefox_choice
if [ "$install_firefox_choice" == "yes" ]; then
    install_firefox
else
    echo "Skipping Firefox installation."
fi

# LibreOffice installation (Flathub)
echo "Do you want to install LibreOffice? (yes/no)"
read install_libreoffice_choice
if [ "$install_libreoffice_choice" == "yes" ]; then
    install_libreoffice
else
    echo "Skipping LibreOffice (Flathub) installation"
fi

# Thunderbird installation (Flathub)
echo "Do you want to install Thunderbird? (yes/no)"
read install_thunderbird_choice
if [ "$install_thunderbird_choice" == "yes" ]; then
    install_thunderbird
else
    echo "Skipping Thunderbird (Flathub) installation."
fi

echo "Installation process completed."