# Installing on framework
### Partitioning
```bash
nix-shell -p git sbctl
git clone https://github.com/janher98/nixos-config flake
cd flake
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko hosts/framework/disko.nix
#sudo mkdir -p /mnt/persist/etc/NetworkManager/system-connections /mnt/persist/etc/secureboot
sudo mkpasswd -m yescrypt >> /mnt/persist/passwords/jan
sudo sbctl create-keys
sudo nixos-install --flake .#framework
```
Reboot after the install
```bash
reboot
```
### Cleanup
```bash
sudo sbctl enroll-keys --microsoft
sudo bootctl status
```
