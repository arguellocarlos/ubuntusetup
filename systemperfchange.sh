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

set_gpu_fancurce() {
    cd /sys/class/drm/card0/device/gpu_od/fan_ctrl/fan_curve/
    echo ""0 30 20" > fan_curve"
    echo ""1 50 25" > fan_curve"
    echo ""2 60 50" > fan_curve"
    echo ""3 70 60" > fan_curve"
    echo ""4 80 100" > fan_curve"
    echo ""c" > fan_curve"
}

# Function to display the menu
display_menu() {
    echo "Choose the CPU governor:"
    echo "1. Performance"
    echo "2. Powersave"
    echo "3. Adjust GPU (Radon 7000) fan curve"
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1) set_governor performance ;;
        2) set_governor powersave ;;
        3) set_gpu_fancurce ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Display the menu
display_menu

# Verify the change
cpupower frequency-info
