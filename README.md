# My little nixos-config
## Installing on a new System
[Framework](./hosts/framework/INSTALL.md)
[Server](./hosts/server/INSTALL.md)
### Rebuilding after a configuration change
```bash
sudo nixos-rebuild switch --flake .#framework
```


## Installing on another system
### Install nix
```bash
sudo mkdir /nix
sudo chown $USER /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
### Cloning the Repo and installing
```bash
git clone https://github.com/janher98/nixos-config $HOME/nixos-config && cd $HOME/nixos-config
. $HOME/.nix-profile/etc/profile.d/nix.sh #to make nix available if there wasn't a reboot
nix build --extra-experimental-features 'nix-command flakes' .#homeConfigurations.cli.activationPackage
./result/activate
```
### Updating after a configuration change
```bash
home-manager switch --flake .#cli
```
