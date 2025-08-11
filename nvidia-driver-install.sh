#!/bin/bash

# Install the headers for your current running kernel 
sudo apt install linux-headers-$(uname -r) -y
sudo ubuntu-drivers install nvidia:550 # Change accordingly to driver version