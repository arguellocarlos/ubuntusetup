#!/bin/bash

# Function to display ASCII art
display_ascii_art() {
    echo " +-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ "
    echo " |U|b|u|n|t|u| |P|o|s|t| |I|n|s|t|a|l|l|a|t|i|o|n| |S|c|r|i|p|t| "
    echo " +-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ "
}

# Function to install applications
install_applications() {
    echo "Run setup.sh (Install various applications)"
    chmod a+x setup.sh
    sudo sh ./setup.sh
    # Add more applications (Or scripts) as needed
}

# Function to perform system changes
perform_system_performance_change() {
    echo "Performing system performance changes..."
    chmod a+x systemperfchange.sh
    sudo sh ./systemperfchange.sh
}

# Main menu
main_menu() {
    while true; do
        echo "Please choose an option:"
        echo "1. Install Applications"
        echo "2. Perform System Performance Changes"
        echo "3. Exit"
        read -p "Enter your choice [1-3]: " choice

        case $choice in
            1) install_applications ;;
            2) perform_system_performance_change ;;
            3) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Display ASCII art
display_ascii_art

# Show the main menu
main_menu
