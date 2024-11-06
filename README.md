# Copilot Explanation
You can use the `cloud-localds` command to create a cloud-init ISO that can be mounted as a CDROM when creating a VM with KVM/QEMU. Here’s how you can do it:

1. **Create the cloud-init configuration files** (`user-data` and `meta-data`):
   ```yaml
   # user-data
   #cloud-config
   runcmd:
     - echo "Hello, World!" > /etc/motd
     - add-apt-repository -y ppa:example/ppa
     - apt-get update
     - apt-get install -y some-package
   ```

   ```yaml
   # meta-data
   instance-id: iid-local01
   local-hostname: ubuntu
   ```

2. **Install the `cloud-image-utils` package** if it's not already installed:
   ```bash
   sudo apt-get install cloud-image-utils
   ```

3. **Create the cloud-init ISO** using `cloud-localds`:
   ```bash
   cloud-localds seed.iso user-data meta-data
   ```

4. **Create the VM using `virt-install` and attach the cloud-init ISO as a CDROM**:
   ```bash
   virt-install --name my-vm --memory 2048 --vcpus 2 \
     --disk path=/var/lib/libvirt/images/my-vm.qcow2,size=20 \
     --disk path=seed.iso,device=cdrom \
     --os-type linux --os-variant ubuntu20.04 \
     --network network=default \
     --graphics none --console pty,target_type=serial \
     --location 'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
     --extra-args 'console=ttyS0,115200n8 serial'
   ```

This method will create a cloud-init ISO that can be used to provide user-data and meta-data to your VM during its creation¹²³.

Source: Conversation with Copilot, 10/29/2024

[(1) cloud-localds (1) — cloud-image-utils — Debian testing — Debian Manpages.](https://manpages.debian.org/testing/cloud-image-utils/cloud-localds.1.en.html.)

[(2) Using Generic Cloud Images on a local machine - AlmaLinux OS.](https://wiki.almalinux.org/cloud/Generic-cloud-on-local.html.)

[(3) Create and use a local cloud-init datasource.](https://documentation.ubuntu.com/public-images/en/latest/public-images-how-to/use-local-cloud-init-ds/.)

[(4) http://almalinux.org/almalinux/8.](http://almalinux.org/almalinux/8.)

[(5) http://almalinux.org/almalinux/9.](http://almalinux.org/almalinux/9.)

[(6) https://releases.pagure.org/libosinfo/?C=M.](https://releases.pagure.org/libosinfo/?C=M.)

[(7) https://releases.pagure.org/libosinfo/osinfo-db-.](https://releases.pagure.org/libosinfo/osinfo-db-.)

[(8) https://wiki.almalinux.org/cloud/Generic-cloud.html.](https://wiki.almalinux.org/cloud/Generic-cloud.html.)