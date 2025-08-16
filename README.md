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

The kernel parameter libata.force=noncq disables Native Command Queuing (NCQ) for SATA devices managed by the libata subsystem. Here's what that means and why you might use it:

Native Command Queuing is a feature in SATA drives that allows them to reorder read/write commands for better performance—especially in multi-threaded workloads.

* 🧠 Think of it like a smart to-do list for your hard drive.
* 📈 It can boost throughput and reduce latency in some cases.

# What libata.force=noncq Does

Disables NCQ for all SATA devices.

Forces the kernel to treat the drive as if it doesn’t support command queuing.

Applies early in the boot process via the kernel command line (e.g., in GRUB).

# When to Use It

## ✅ Good Reasons:

You're experiencing I/O errors, freezes, or timeouts with certain SSDs or HDDs.

Your drive or controller has buggy NCQ support.

You're troubleshooting disk performance issues.

## ❌ Not Ideal If:

Your drive benefits from NCQ (e.g., in high-throughput workloads).

You're using modern SSDs with good NCQ support.

# 🛠️ How to Apply It

```sudo nano /etc/default/grub```

Add to the ```GRUB_CMDLINE_LINUX_DEFAULT``` line:

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash ```libata.force=noncq"```

Source: Conversation with Copilot, 08/16/2025