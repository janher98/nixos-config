# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stable, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++
           ( import ../../modules/desktops/virtualisation );

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      mirroredBoots = [
        { devices = [ "nodev"]; path = "/boot"; }
      ];
    };
   # efi.canTouchEfiVariables = true;
   # efi.SysMountPoint = "/boot/efi";

  };
  gnome.enable = true;
  #hyprland.enable = true;

  #hardware.graphics.enable = true; # when using QEMU KVM
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  qemu
    anki-bin
  ];
  services = {
    xrdp = {
      enable = true;
      defaultWindowManager = "gnome-session";
      openFirewall = true;
    };
  };
  # List services that you want to enable:

}
