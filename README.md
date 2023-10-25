# nixos-config
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