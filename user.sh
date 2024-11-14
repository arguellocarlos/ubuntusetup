#!/bin/bash

# Prompt for the new username
read -p "Enter the new username: " username

# Create the new user and add to sudo group
sudo adduser $username
sudo usermod -aG sudo $username

# Create user home directory and default directories
sudo mkdir -p /home/$username/{Documents,Pictures,Videos,Downloads,Music,Desktop}

# Set ownership of the home directory to the new user
sudo chown -R $username:$username /home/$username

echo "User $username created with sudo privileges and home directories set up."
