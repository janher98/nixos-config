# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stable, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++
           ( import ../../modules/desktops/virtualisation ++
             import ../../modules/server);

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      zfsSupport = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      mirroredBoots = [
        { devices = [ "nodev"]; path = "/boot"; }
      ];
    };
    #efi.canTouchEfiVariables = true;
  };
  #networking.hostName = "server"; # Define your hostname.

  hardware.graphics.enable = true; # when using QEMU KVM
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    qemu
  ];
  services = {
    nfs.server = {
      enable = true;
      lockdPort = 4001; #following for nfv3, requiring fixed ports
      mountdPort = 4002;
      statdPort = 4000;
      extraNfsdConfig = '''';
      exports = ''
        /nasdata 192.168.234.0/24(rw,nohide,insecure,no_subtree_check)
      '';
    };
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.234. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "public" = {
        "path" = "/nasdata";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
          #"force user" = "jan";
          #"force group" = "jan";
        };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
  #services.zfs = {
  #  autoScrub.enable = true;
  #  trim.enable = true;
  #};
  # List services that you want to enable:

}
