#!/bin/bash

if [[ "$USER" != "root" ]]; then
    echo "You need to run this script as root or sudo"
    exit 1
fi

# You may need to adjust this
cd /sys/class/drm/card0/device/gpu_od/fan_ctrl/fan_curve/

echo "0 30 20" > fan_curve
echo "1 50 25" > fan_curve
echo "2 60 50" > fan_curve
echo "3 70 60" > fan_curve
echo "4 80 100" > fan_curve
echo "c" > fan_curve