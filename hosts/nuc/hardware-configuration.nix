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
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/local/root@blank
      '';
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      #extraPools = [ "nextcloud" "NAS_data" "Backup_data"];
    };
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3A31-3202";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022"];
    };

  fileSystems."/" =
    { device = "rpool/local/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "rpool/local/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/safe/home";
      fsType = "zfs";
    };

  fileSystems."/persist" =
    { device = "rpool/safe/persist";
      fsType = "zfs";
    };

  networking = with host; {
    hostName = hostName;
    hostId = "3da9ba0f";
    networkmanager.enable = true;
    interfaces.enp86s0.ipv4 = {
      addresses = [
        {
          address = "192.168.1.11";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway.address = "192.168.1.1";
    firewall.allowedTCPPorts = [ 80 443 ];
    nameservers = [
      "1.1.1.1"
    ];
  };
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}