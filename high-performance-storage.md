# Ugreen DXP2800 high-performance-storage build (destructive)

## 0) Sanity: double-check device names (THIS WILL WIPE THESE DEVICES)

```lsblk -o NAME,SIZE,MODEL,TYPE```

## 1) Create RAID0 on HDDs with 1 MiB chunk

```sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 --metadata=1.2 --chunk=1024 /dev/sda /dev/sdb```

Or,

```sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 --metadata=1.2 --chunk=512 /dev/sda /dev/sdb```

## Persist mdadm config

```sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf```

And,

```sudo update-initramfs -u```

## 2) LVM PVs and VG (HDD array + both NVMes in one VG)
```sudo pvcreate /dev/md0```

And,

```sudo pvcreate /dev/nvme2n1```

And,

```sudo pvcreate /dev/nvme3n1```

And,

```sudo vgcreate vgdata /dev/md0 /dev/nvme2n1 /dev/nvme3n1```

## 3) Origin LV on HDDs ONLY, using 100% of md0

```sudo lvcreate -n data -l 100%FREE vgdata /dev/md0```

## 4) Cache LVs on NVMes ONLY: 956G data + 200G metadata, striped over both NVMes

Use 512 KiB stripe size on cache LVs (good balance for NVMe)

```sudo lvcreate -n cachedata -L 956G -i 2 -I 512 vgdata /dev/nvme2n1 /dev/nvme3n1```

And,

```sudo lvcreate -n cachemeta -L 200G -i 2 -I 512 vgdata /dev/nvme2n1 /dev/nvme3n1```

## 5) Turn them into a cache pool with 1 MiB cache chunk size

```sudo lvconvert --type cache-pool --poolmetadata vgdata/cachemeta --chunksize 1M vgdata/cachedata```

## 6) Attach the cache pool to the origin LV

```sudo lvconvert --type cache --cachepool vgdata/cachedata vgdata/data```

## 7) Start in writethrough for safety (switch to writeback later)

```sudo lvchange --cachemode writethrough vgdata/data```

## XFS/EXT4 format and mount

XFS formatted for a 2-disk RAID0 with 1 MiB chunk: set su=1m (stripe unit), sw=2 (stripe width)

```sudo mkfs.xfs -f -d su=1m,sw=2 -l su=1m /dev/vgdata/data```

EXT4 formatted for a 2-disk RAID0 with 1 MiB chunk: set su=1m (stripe unit), sw=2 (stripe width)

```sudo mkfs.ext4 -F -E stride=256,stripe-width=512 /dev/vgdata/data```

## Mount
```sudo mkdir -p /mnt/data```

And,

```sudo mount /dev/vgdata/data /mnt/data```

# Persist via fstab (use UUID)

```UUID=$(sudo blkid -o value -s UUID /dev/vgdata/data)```

And,

```echo "UUID=$UUID  /mnt/data  xfs  noatime,defaults  0  2" | sudo tee -a /etc/fstab```

## Performance knobs for this workload

## Cache mode:

Writeback (faster, power-loss risk without UPS):

```sudo lvchange --cachemode writeback vgdata/data```

## Cache policy:
Keep default smq for mixed sequential/bursty workloads:

```sudo lvchange --cachepolicy smq vgdata/data```

## Readahead (HDD array):
Increase to help large sequential reads:

```sudo blockdev --setra 16384 /dev/md0```

## Schedulers:
HDD array: mq-deadline

```echo mq-deadline | sudo tee /sys/block/md0/queue/scheduler```

NVMe: none or [kyber](https://lwn.net/Articles/720675/) | [Tuning I/O Performance](https://documentation.suse.com/en-us/sles/12-SP5/html/SLES-all/cha-tuning-io.html) (often auto)

```echo none | sudo tee /sys/block/nvme2n1/queue/scheduler```

```echo none | sudo tee /sys/block/nvme3n1/queue/scheduler```

## Verify and persist
Array and LVM health:

```cat /proc/mdstat```

```sudo mdadm --detail /dev/md0```

```sudo pvs; sudo vgs```

```sudo lvs -a -o +devices,segtype,cache_mode,chunk_size```

## Follow-up cleanup for LVM and mdadm

```sudo mdadm --stop /dev/md0```

And,

```sudo mdadm --zero-superblock /dev/sda```

And,

```sudo mdadm --zero-superblock /dev/sdb```

And,

```sudo wipefs -a /dev/sda```

And,

```sudo wipefs -a /dev/sdb```

## Follow-up cleanup for LVM

```sudo pvremove /dev/sda /dev/sdb /dev/nvme2n1 /dev/nvme3n1```

And,

```sudo vgremove vgdata```

And,

```sudo lvremove -f vgdata```

And,

```sudo vgscan --cache```