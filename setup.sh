#!/bin/bash

# Function to display ASCII art
#display_ascii_art() {
#    echo "=================================="
#    echo "  _    _ _   _ _    _ _   _       "
#    echo " | |  | | | | | |  | | | | |      "
#    echo " | |  | | |_| | |  | | |_| |      "
#    echo " | |  | |  _  | |  | |  _  |      "
#    echo " | |__| | | | | |__| | | | |      "
#    echo "  \\____/|_| |_|\\____/|_| |_|      "
#    echo "                                  "
#    echo "  Ubuntu Post Installation Script "
#    echo "=================================="
#}

# Define global color variable
UFO_Green='\033[1;38;5;78m' # Bold UFO Green https://www.colorxs.com/color/hex-33da7a
NC='\033[1;37m' # Default white

# Function to install Bitwarden
install_bitwarden() {
    echo -e "${UFO_Green}Installing the latest Bitwarden Desktop version...${NC}"
#    latest_release=$(curl -s https://api.github.com/repos/bitwarden/clients/releases/latest | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4)
#    wget -O bitwarden-latest-amd64.deb $latest_release
#    sudo apt install ./bitwarden-latest-amd64.deb
#    sudo apt install -f
#    rm bitwarden-latest-amd64.deb
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.bitwarden.desktop -y
}

# Function to install Brave browser
install_brave() {
    echo -e "${UFO_Green}Installing Brave browser...${NC}"
    sudo apt install curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser -y
}

# Function to install Docker
install_docker() {
    echo -e "${UFO_Green}Installing Docker...${NC}"
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
    echo -e "${UFO_Green}Installing Google Chrome...${NC}"
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update -y
    sudo apt install google-chrome-stable -y
}

# Function to install Kisak Mesa Fresh
install_kisakmesa(){
    echo -e "${UFO_Green}Installing Kisak Mesa Fresh PPA...${NC}"
    sudo add-apt-repository ppa:kisak/kisak-mesa -y
    sudo apt update -y
    sudo apt upgrade -y
}

# Function to install OBS Studio
install_obstudio(){
    echo -e "${UFO_Green}Installing OBS Studio...${NC}"
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt update -y
    sudo apt install ffmpeg obs-studio -y
}

# Function to remove Snap Packages
remove_snaps() {
    echo -e "${UFO_Green}Removing Snap Packages...${NC}"
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
    echo -e "${UFO_Green}Disabling Snap services...${NC}"
    sudo systemctl stop snapd
    sudo systemctl disable snapd
    sudo systemctl mask snapd
    
    echo -e "${UFO_Green}Removing Snap apt package...${NC}"
    sudo apt remove --purge snapd -y && sudo apt-mark hold snapd
    
    rm -rf ~/snap/
    sudo rm -rf /var/snap
    sudo rm -rf /var/lib/snapd
}

# Function to install Parsec
install_parsec(){
    echo -e "${UFO_Green}Installing Parsec...${NC}"
    wget --show-progress https://builds.parsec.app/package/parsec-linux.deb
    sudo dpkg -i parsec-linux.deb
    sudo apt install -f
}

# Function to install AnyDesk
install_anydesk(){
    echo -e "${UFO_Green}Installing AnyDesk...${NC}"
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
    echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
    sudo apt update -y
    sudo apt install anydesk -y
}

install_rclone(){
    sudo apt install p7zip-full unzip -y
    # Define the installation directory
    INSTALL_DIR="/opt/rclone"
    # Create the installation directory
    sudo mkdir -p $INSTALL_DIR
    # Download the latest rclone release
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
    # Unzip the downloaded file
    unzip rclone-current-linux-amd64.zip
    # Change to the unzipped directory
    cd rclone-*-linux-amd64
    # Move the rclone binary to the installation directory
    sudo mv rclone $INSTALL_DIR
    # Set the appropriate permissions
    sudo chown root:root $INSTALL_DIR/rclone
    sudo chmod 755 $INSTALL_DIR/rclone
    # Clean up the downloaded and unzipped files
    cd ..
    rm -rf rclone-*-linux-amd64 rclone-current-linux-amd64.zip
    # Create a symbolic link to make rclone accessible from anywhere
    sudo ln -s $INSTALL_DIR/rclone /usr/bin/rclone
    # Verify the installation
    rclone version
    echo -e "${UFO_Green}rclone has been installed to $INSTALL_DIR and linked to /usr/bin/rclone${NC}"
}

# Function to install Applications (Without Snap support)

install_firefox(){
    echo -e "${UFO_Green}Installing Firefox (Without Snap)...${NC}"
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
    echo -e "${UFO_Green}Installing LibreOffice (Flathub)${NC}"
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.libreoffice.LibreOffice -y
}

install_thunderbird(){
    echo -e "${UFO_Green}Installing Thunderbird (Flathub)${NC}"
    sudo apt install flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.mozilla.Thunderbird -y
}

# Check Ubuntu version
ubuntu_version=$(lsb_release -rs)
if [ "$ubuntu_version" == "24.04" ]; then
    echo -e "${UFO_Green}Running on Ubuntu 24.04.${NC}"
    echo -e "${UFO_Green}Do you want to remove Snap Support? (yes/no)${NC}"
    read remove_snap_choice
    if [ "$remove_snap_choice" == "yes" ]; then
        remove_snaps
    else
        echo -e "${UFO_Green}Skipping Snap removal.${NC}"
    fi
elif [ "$ubuntu_version" == "24.04" ] || [ "$ubuntu_version" == "24.10" ]; then
    echo -e "${UFO_Green}Running on Ubuntu $ubuntu_version.${NC}"
else
    echo -e "${UFO_Green}This script is designed for Ubuntu 24.04 or 24.10. Exiting.${NC}"
    exit 1
fi

# Prompt user for each installation

echo -e "${UFO_Green}Do you want to install the latest Bitwarden Desktop version? (yes/no)${NC}"
read install_bitwarden_choice
if [ "$install_bitwarden_choice" == "yes" ]; then
    install_bitwarden
else
    echo -e "${UFO_Green}Skipping Bitwarden installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install Brave browser? (yes/no)${NC}"
read install_brave_choice
if [ "$install_brave_choice" == "yes" ]; then
    install_brave
else
    echo -e "${UFO_Green}Skipping Brave browser installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install Docker? (yes/no)${NC}"
read install_docker_choice
if [ "$install_docker_choice" == "yes" ]; then
    install_docker
else
    echo -e "${UFO_Green}Skipping Docker installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install Google Chrome? (yes/no)${NC}"
read install_chrome_choice
if [ "$install_chrome_choice" == "yes" ]; then
    install_chrome
else
    echo -e "${UFO_Green}Skipping Google Chrome installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install Kisak Mesa Fresh PPA? (yes/no)${NC}"
read install_kisakmesa_choice
if [ "$install_kisakmesa_choice" == "yes" ]; then
    install_kisakmesa
else
    echo -e "${UFO_Green}Skipping Kisak Mesa Fresh installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install OBS Studio? (yes/no)${NC}"
read install_obstudio_choice
if [ "$install_obstudio_choice" == "yes" ]; then
    install_obstudio
else
    echo -e "${UFO_Green}Skipping OBS Studio installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install Parsec? (yes/no)${NC}"
read install_parsec_choice
if [ "$install_parsec_choice" == "yes" ]; then
    install_parsec
else
    echo -e "${UFO_Green}Skipping Parsec installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install AnyDesk? (yes/no)${NC}"
read install_anydesk_choice
if [ "$install_anydesk_choice" == "yes" ]; then
    install_anydesk
else
    echo -e "${UFO_Green}Skipping AnyDesk installation.${NC}"
fi

echo -e "${UFO_Green}Do you want to install rclone? (yes/no)${NC}"
read install_rclone_choice
if [ "$install_rclone_choice" == "yes" ]; then
    install_rclone
else
    echo -e "${UFO_Green}Skipping rclone installation.${NC}"
fi

# Snap removal if running on Ubuntu 24.04 and 24.10
if [ "$ubuntu_version" == "24.04" ] || [ "$ubuntu_version" == "24.10" ]; then
    echo -e "${UFO_Green}Do you want to remove Snap packages support? (yes/no)${NC}"
    read remove_snap_choice
    if [ "$remove_snap_choice" == "yes" ]; then
        remove_snaps
    else
        echo -e "${UFO_Green}Skipping Snap packages removal.${NC}"
    fi
fi

# Firefox installation without Snap Support
echo -e "${UFO_Green}Do you want to install Firefox? (yes/no)${NC}"
read install_firefox_choice
if [ "$install_firefox_choice" == "yes" ]; then
    install_firefox
else
    echo -e "${UFO_Green}Skipping Firefox installation.${NC}"
fi

# LibreOffice installation (Flathub)
echo -e "${UFO_Green}Do you want to install LibreOffice? (yes/no)${NC}"
read install_libreoffice_choice
if [ "$install_libreoffice_choice" == "yes" ]; then
    install_libreoffice
else
    echo -e "${UFO_Green}Skipping LibreOffice (Flathub) installation${NC}"
fi

# Thunderbird installation (Flathub)
echo -e "${UFO_Green}Do you want to install Thunderbird? (yes/no)${NC}"
read install_thunderbird_choice
if [ "$install_thunderbird_choice" == "yes" ]; then
    install_thunderbird
else
    echo -e "${UFO_Green}Skipping Thunderbird (Flathub) installation.${NC}"
fi

# display_ascii_art

echo -e "${UFO_Green}Installation process completed.${NC}"