#!/bin/bash

# Function to display ASCII art
display_ascii_art() {
    echo " +-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ "
    echo " |U|b|u|n|t|u| |P|o|s|t| |I|n|s|t|a|l|l|a|t|i|o|n| |S|c|r|i|p|t| "
    echo " +-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ "
}

# Function to install applications
perform_application_installation() {
    echo "Run setup.sh (Install various applications)"
    chmod a+x setup.sh
    sudo ./setup.sh
    # Add more applications (Or scripts) as needed
}

# Function to perform system changes
perform_system_performance_change() {
    echo "Performing system performance changes..."
    chmod a+x systemperfchange.sh
    sudo ./systemperfchange.sh
}

# Function to install the Nvidia Driver 550 (Static)
perform_install_nvidia_driver() {
    echo "Installing the Nvidia Driver..."
    chmod a+x nvidia-driver-install.sh
    sudo ./nvidia-driver-install.sh
}

perform_radeon7000_fan_curve() {
    echo "Adjusting GPU Fan Curve..."
    chmod a+x fan_curve.sh
    sudo ./fan_curve.sh
}

perform_linux_firmware_installation() {
    echo "Installing Linux Firmware..."
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install --reinstall linux-firmware -y
    sync
}

# Main menu
main_menu() {
    while true; do
        echo "Please choose an option:"
        echo "1. Install Applications..."
        echo "2. Perform System Performance Changes..."
        echo "3. Install Nvidia Driver..."
        echo "4. Perform Radeon 7000 GPU Fan Curve adjustment..."
        echo "5. Perform Linux Firmware Installation..."
        echo "6. Exit..."
        read -p "Enter your choice [1-6]: " choice

        case $choice in
            1) perform_application_installation ;;
            2) perform_system_performance_change ;;
            3) perform_install_nvidia_driver ;;
            4) perform_radeon7000_fan_curve ;;
            5) perform_linux_firmware_installation ;;
            6) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option. Please try again..." ;;
        esac
    done
}

# Display ASCII art
display_ascii_art

# Show the main menu
main_menu
