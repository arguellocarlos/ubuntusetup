## From Arch Linux Multilib Development Image
## install base packages and Intel GPU drivers
## https://gitlab.freedesktop.org/drm/igt-gpu-tools 

FROM archlinux:multilib-devel

# Initialize pacman keyring and populate Arch Linux keys
RUN pacman-key --init && \
    pacman-key --populate archlinux

# Update system and install packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base intel-compute-runtime intel-gpu-tools

CMD ["/bin/bash"]