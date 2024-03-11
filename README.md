# nixos-config
```bash
sudo parted /dev/nvme0n1 -- mklabel gpt
sudo parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 1 esp on
sudo parted /dev/nvme0n1 -- mkpart primary 512MiB -32GiB
sudo parted /dev/nvme0n1 -- mkpart primary linux-swap -32GiB 100%
```
```bash
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1   
sudo mkfs.ext4 -L nixos /dev/nvme0n1p2
sudo mkswap -L swap /dev/nvme0n1p3
sudo swapon /dev/nvme0n1p3
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot                     
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo nixos-generate-config --root /mnt
```
```bash
sudo su
nix-env -iA nixos.git
git clone https://github.com/janher98/nixos-config /mnt/home/jan/flake
cd /mnt/home/jan/flake
nixos-install --flake .#jan
```
```bash
reboot
```
login
```bash
sudo rm -r /etc/nixos/configuration.nix
```
move build to desired location


```bash
nix build .#homeConfigurations.cli.activationPackage
./result/activate
```
```bash
home-manager switch --flake .#cli
```
