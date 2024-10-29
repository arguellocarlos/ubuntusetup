#!/bin/bash

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

# Prompt user for each installation
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

echo "Installation process completed."