To passthrough a network interface to a VM using `virsh` and ensure the best performance, you can use the `attach-interface` command with the `virtio` model, which is optimized for performance. Here’s an example command:

```bash
sudo virsh attach-interface --domain VM_NAME --type direct --source INTERFACE_NAME --model virtio --config --live
```

Here's a breakdown of the command:
- `--domain VM_NAME`: Specifies the name of the VM.
- `--type direct`: Indicates that the interface is directly attached.
- `--source INTERFACE_NAME`: The name of the host network interface you want to passthrough.
- `--model virtio`: Uses the `virtio` model for better performance.
- `--config`: Makes the change persistent across reboots.
- `--live`: Applies the change immediately without needing to restart the VM.

For example, if your VM is named `Ubuntu2004` and the network interface you want to passthrough is `eth0`, the command would look like this:

```bash
sudo virsh attach-interface --domain Ubuntu2004 --type direct --source eth0 --model virtio --config --live
```

Using the `virtio` model helps in achieving better performance due to its paravirtualized nature, which reduces overhead compared to emulated devices¹².

Source: Conversation with Copilot, 11/6/2024

[(1) Red Hat Documentation on Optimizing VM Performance](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_virtualization/optimizing-virtual-machine-performance-in-rhel_configuring-and-managing-virtualization)

[2) Managing KVM Network Interfaces](https://computingforgeeks.com/managing-kvm-network-interfaces-in-linux/)

***

[(1) Chapter 17. Optimizing virtual machine performance - Red Hat.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_virtualization/optimizing-virtual-machine-performance-in-rhel_configuring-and-managing-virtualization.)

[(2) Chapter 20. Managing Guest Virtual Machines with virsh.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/chap-managing_guest_virtual_machines_with_virsh.)

[(3) Configure KVM Networking With virsh, nmcli and brctl in Linux.](https://computingforgeeks.com/managing-kvm-network-interfaces-in-linux/.)

[(4) 20 Virsh Commands for Managing VMs | Virsh CLI Guide.](https://www.basezap.com/20-virsh-commands-for-managing-vms/.)

[(5) Configuring Virtual Machines with virsh | Virtualization Guide...](https://doc.opensuse.org/documentation/leap/archive/15.2/virtualization/html/book-virt/cha-libvirt-config-virsh.html.)