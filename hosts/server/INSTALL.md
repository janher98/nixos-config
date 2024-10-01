# Installing on Server
### Partitioning
```bash
sudo parted /dev/nvme0n1 -- mklabel gpt
sudo parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 1 esp on
sudo parted /dev/nvme0n1 -- mkpart primary 512MiB -32GiB
sudo parted /dev/nvme0n1 -- mkpart primary linux-swap -32GiB 100%
```
### Formatting
```bash
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1
sudo mkswap -L swap /dev/nvme0n1p3
```
### Zpools
```bash
sudo zpool create -O mountpoint=none -O xattr=sa -O acltype=posixacl -o ashift=12 rpool /dev/nvme0n1p2
sudo zfs create -p -o mountpoint=legacy rpool/local/root
sudo zfs snapshot rpool/local/root@blank
sudo zfs create -p -o mountpoint=legacy rpool/local/nixos
sudo zfs create -p -o mountpoint=legacy rpool/safe/home
sudo zfs create -p -o mountpoint=legacy rpool/safe/persist
```

### Mounting
```bash
sudo swapon /dev/nvme0n1p3
sudo mount -t zfs rpool/local/root /mnt
sudo mkdir -p /mnt/boot /mnt/nix /mnt/home /mnt/persist
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo mount -t zfs rpool/local/nix /mnt/nix
sudo mount -t zfs rpool/safe/home /mnt/home
sudo mount -t zfs rpool/safe/persist /mnt/persist
```
### Installing
```bash
sudo nixos-generate-config --root /mnt
```
```bash
sudo su
nix-shell -p git
git clone https://github.com/janher98/nixos-config /mnt/home/jan/flake
cd /mnt/home/jan/flake
nixos-install --flake .#server
```
Reboot after the install
