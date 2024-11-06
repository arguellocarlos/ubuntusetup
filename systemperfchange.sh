#!/bin/bash

# Ensure cpupower is installed
sudo apt update -y
sudo apt install linux-tools-common linux-tools-generic -y

# Function to set the CPU governor
set_governor() {
    local governor=$1
    echo "Setting CPU governor to $governor..."
    sudo cpupower frequency-set --governor $governor
    echo "CPU governor set to $governor."
}

# Function to display the menu
display_menu() {
    echo "Choose the CPU governor:"
    echo "1. Performance"
    echo "2. Powersave"
    read -p "Enter your choice [1-2]: " choice

    case $choice in
        1) set_governor performance ;;
        2) set_governor powersave ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Display the menu
display_menu

# Verify the change
cpupower frequency-info
