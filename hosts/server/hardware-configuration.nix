# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, host, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      #extraPools = [ "nextcloud" "NAS_data" "Backup_data"];
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b09c6312-f2ae-4dd6-96ac-8ff0722beec2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9A79-79AD";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/488bd0a5-8a28-4ba4-8ee1-0644ba5990a5"; }
    ];

  #  fileSystems."/mnt/nextcloud" = {
  #  device = "nextcloud";
  #  fsType = "zfs";
  #};
  #fileSystems."/mnt/backup" = {
  #  device = "Backup_data";
  #  fsType = "zfs";
  #};
  #
  #fileSystems."/mnt/NAS" = {
  #  device = "NAS_data";
  #  fsType = "zfs";
  #};

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networkings
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  networking = with host; {
    hostName = hostName;
    hostId = "3da9ba0f";
    networkmanager.enable = true;
    interfaces.enp2s0.ipv4 = {
      addresses = [
        {
          address = "192.168.234.8";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway.address = "192.168.234.1";
    firewall.allowedTCPPorts = [ 80 443 ];
    nameservers = [
      "1.1.1.1"
    ];
  };
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
