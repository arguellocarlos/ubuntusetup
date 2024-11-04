sudo apt update -y && sudo apt install git -y && cd ~/Documents/ && git clone https://github.com/arguellocarlos/ubuntusetup.git
sudo apt clean
sync && cd ubuntusetup/
chmod a+x setup.sh 
sudo ./setup.sh 
sudo dpkg -i parsec-linux.deb 
sudo apt install -f
sudo apt install ./parsec-linux.deb 
sudo apt --fix-broken install
sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt install libavcodec-dev -y
sudo apt install ./parsec-linux.deb 
sudo apt search libavcodec
sudo apt install libavcodec-extra -y
sudo apt install ./parsec-linux.deb 
sudo apt install --reinstall ubuntu-restricted-extras libav-tools ffmpeg gstreamer1.0-libav -y
sudo apt install --reinstall ubuntu-restricted-extras ffmpeg gstreamer1.0-libav -y
sudo apt clean
sync
rm -rf setup.sh
git pull origin main 
chmod a+x setup.sh 
sudo ./setup.sh 
sudo systemctl restart anydesk.service 
sudo status anydesk.service
sudo systemctl status anydesk.service
sync
sudo apt clean
sudo reboot 
rm -rf snap/
sync
exit
cd Documents/ubuntusetup/
sudo apt remove --purge gnome-shell-extension-ubuntu-dock gnome-shell-extension-ubuntu-tiling-assistant
sync
sudo apt clean
sudo ubuntu-drivers list
#sudo ubuntu-drivers install nvidia:560
sync
sudo apt search libavcodec
sudo apt search libavcodec6
sudo apt install libavcodec61 libavcodec-extra61 -y
sudo apt install libavcodec61 -y
sudo apt remove libavcodec61 -y && sudo apt autoremove -y && sudo apt install --reinstall ffmpeg libavcodec-extra61 libavcodec-extra
sync
sudo apt clean
sudo apt install --reinstall libzvbi-common
sudo apt install --reinstall mesa-vdpau-drivers
sudo ubuntu-drivers install nvidia:560
sudo apt install --reinstall libaacs0 libcodec2-1.2 libjack-jackd2-0 libopenmpt0t64 libshine3
sudo apt install --reinstall libswresample5 libzix-0-0 ocl-icd-libopencl1
sudo apt clean
sync
sudo apt install --reinstall libaribb24-0t64 libdav1d7 libjxl0.10 libpgm-5.3-0t64 libsndio7.0 libswscale8 libzmq5 pocketsphinx-en-us libass9 libdc1394-25 liblapack3 libplacebo349 libsodium23
sync
sudo apt clean
sudo apt install --reinstall libudfread0 libzvbi-common libavutil-dev libdvdnav4 liblilv-0-0 libpocketsphinx3 libsord-0-0 libunibreak6 libzvbi0t64 vdpau-driver-all libavutil59 libfftw3-double3 libmbedcrypto7t64 libpostproc58 libsoxr0 libvdpau1 linux-headers-6.11.0-8 libbdplus0 libflite1 libmysofa1 librabbitmq4 libsphinxbase3t64 libvidstab1.1
sync
sudo apt clean
sudo apt install --reinstall linux-headers-6.11.0-8-generic libblas3 libgfortran5 libnorm1t64 librav1e0.7 libsratom-0-0 libvo-amrwbenc0 linux-modules-6.11.0-8-generic
sync
sudo apt clean
sync
sudo apt full-upgrade -y
sudo apt install --reinstall libbluray2 libgl1-amber-dri libopenal-data librist4 libsrt1.5-gnutls libvpl2 linux-modules-extra-6.11.0-8-generic libbs2b0 libgme0 libopenal1 librubberband2
sync
sudo apt install --reinstall libssh-4 libx265-209 linux-tools-6.11.0-8 libchromaprint1 libgsm1 libopencore-amrnb0 libsdl2-2.0-0 libsvtav1enc2 libxvidcore4 linux-tools-6.11.0-8-generic libcjson1 libhwy1t64 libopencore-amrwb0 libserd-0-0 libswresample-dev libzimg2 mesa-vdpau-drivers
sync
sudo apt clean
sync
sudo reboot
sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt install gparted -y
sync
sudo apt clean
cd Downloads/
ls
sudo dpkg -i Bitwarden-2024.10.2-amd64.deb 
sync
sudo apt clean
rm Bitwarden-2024.10.2-amd64.deb 
ls
sudo apt search intel-media-va-driver-non-free
sudo apt update -y && sudo apt install intel-media-va-driver-non-free -y
sync
sudo apt clean
sudo apt autoremove -y
sudo apt search ubuntu-restricted-addons
sudo apt search ubuntu-restricted-extras
sudo apt install --reinstall linux-firmware
sync
sudo dpkg -i peazip_10.0.0.LINUX.GTK2-1_amd64.deb
sync
sudo apt clean
sudo dpkg -i code_1.95.0-1730153583_amd64.deb
ls
rm -rf *
sync
cd ~/Documents/
ls
cd ubuntusetup/
ls
sudo ./setup.sh 
sync
sudo apt clean
sudo nano -cw /etc/apt/sources.list
cd /etc/apt/sources.list.d/
ls
sudo rm -rf ubuntu.sources
cat ubuntu.sources.curtin.orig 
sync
sudo apt update -y
sync
sudo apt clean
sudo update-grub
sync
sudo reboot 
ip addr
egrep -c '(vmx|svm)' /proc/cpuinfo  && sudo apt install -y qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils -y
sync
sudo apt clean
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y && sudo systemctl enable --now libvirtd && sudo systemctl start libvirtd 
sync
sudo systemctl enable --now libvirtd && sudo systemctl start libvirtd 
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo systemctl status libvirtd
cd /etc/netplan/
ls
sudo apt-get install cloud-image-utils -y
sudo apt clean
sync
ls -l ~/.ssh/id_*.pub
ssh-keygen -t rsa -b 4096 -C "carlos@arguellocarlos.com"
ls ~/.ssh/id_*
ssh-copy-id
cat ~/.ssh/id_rsa.pub
cloud-localds seed.iso user-data meta-data
sudo cp -r seed.iso /var/lib/libvirt/images/
cd /var/lib/libvirt/images/
ls
sudo ls
pwd
sync
cd
virt-install --name ubuntu-cloudimg-2204 --ram 6144 --vcpus 6 --disk path=/var/lib/libvirt/images/ubuntu-cloudimg-2204.qcow2,size=56 --os-type linux --os-variant ubuntu22.04 --network bridge=br0 --graphics none --console pty,target_type=serial --location 'http://archive.ubuntu.com/ubuntu/dists/jammy/main/installer-amd64/' --extra-args 'console=ttyS0,115200n8 serial' --disk path=/var/lib/libvirt/images/seed.iso,device=cdrom
virt-install --name ubuntu-cloudimg-2204 --ram 6144 --vcpus 6 --disk path=/var/lib/libvirt/images/ubuntu-cloudimg-2204.qcow2,size=56 --os-variant ubuntu22.04 --network bridge=br0 --graphics none --console pty,target_type=serial --location 'http://archive.ubuntu.com/ubuntu/dists/jammy/main/installer-amd64/' --extra-args 'console=ttyS0,115200n8 serial' --disk path=/var/lib/libvirt/images/seed.iso,device=cdrom
virt-install --name ubuntu-cloudimg-2004 --ram 6144 --vcpus 6 --disk path=/var/lib/libvirt/images/ubuntu-cloudimg-2004.qcow2,size=56 --os-type linux --os-variant ubuntu20.04 --network bridge=br0 --graphics none --console pty,target_type=serial --location 'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' --extra-args 'console=ttyS0,115200n8 serial' --disk path=/var/lib/libvirt/images/seed.iso,device=cdrom
exit
ip addr
virsh list --all 
virsh reboot ubuntu-cloudimg-2004 
virsh net-info 
virsh cpu-stats ubuntu-cloudimg-2004 
virsh console ubuntu-cloudimg-2004 
virsh shutdown ubuntu-cloudimg-2004
virsh edit ubuntu-cloudimg-2004 
virsh console ubuntu-cloudimg-2004 
virsh console --force ubuntu-cloudimg-2004 
virsh shutdown ubuntu-cloudimg-2004
ip addr
virsh list --all 
ssh ubuntu@192.168.122.117
ssh ubuntu-cloudimg-2004@192.168.122.117
ssh ubuntu-cloudimg@192.168.122.117
ssh root@192.168.122.117
ssh ubuntu-cloudimg-2004@192.168.122.117
virsh console --force ubuntu-cloudimg-2004 
virsh shutdown ubuntu-cloudimg-2004
exit
ip addr
cd /etc/netplan/
sudo nano -cw 01-netcfg.yaml
ip addr
netsat
sudo apt install net-tools -y
sync
sudo apt clean
netstat 
sudo virsh reboot ubuntu-cloudimg-2004 
ssh-copy-id ubuntu-cloudimg-2004@192.168.122.117
exit
ip addr
ip address show 
virt-install --name ubuntu2004-cloudimg --ram 6144 --vcpus 6 --disk path=/var/lib/libvirt/images/ubuntu2004-cloudimg.qcow2,size=56 --os-type linux --os-variant ubuntu20.04 --network bridge=br0 --graphics none --console pty,target_type=serial --location 'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' --extra-args 'console=ttyS0,115200n8 serial' --disk path=/var/lib/libvirt/images/seed.iso,device=cdrom
virsh console ubuntu2004-cloudimg 
exit
sudo virsh list all
sudo virsh list
sudo virsh list --all
exit
sudo virsh destroy --graceful --remove-logs ubuntu-cloudimg-2004
sudo virsh vol-delete ubuntu-cloudimg-2004
sudo virsh undefine ubuntu-cloudimg-2004
sudo virsh undefine --domain ubuntu2004-cloudimg
sudo ls /var/lib/libvirt/images/
sudo rm -rf /var/lib/libvirt/images/ubuntu-cloudimg-2004.qcow2
sync
df -h
exit
sudo virsh shutdown ubuntu2004-cloudimg 
sudo virsh start ubuntu2004-cloudimg 
ssh-copy-id ubuntu2004-cloudimg@192.168.122.234
ssh ubuntu2004-cloudimg@192.168.122.234
ssh-copy-id ubuntu2004-cloudimg@192.168.122.234
ssh-keygen -f '/home/gigabyte/.ssh/known_hosts' -R '192.168.122.234'
ssh-copy-id ubuntu2004-cloudimg@192.168.122.234
ssh ubuntu2004-cloudimg@192.168.122.234