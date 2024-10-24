{

  fileSystems = {
    "/persist" = {
      neededForBoot = true;
    };
  };

  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";

        content = {
          type = "gpt";

          partitions = {
            esp = {
              size = "5G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";

                mountOptions = [ "defaults" "umask=0077" ];
              };
            };

            lvm = {
              size = "100%";

              content = {
                  type = "lvm_pv";
                  vg   = "pool";
              };
            };
          };
        };
      };
    };

    lvm_vg = {
      pool = {
        type = "lvm_vg";

        lvs = {
          root = {
            size = "100%FREE";

            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];

              subvolumes = {
                "/persist" = {
                  mountpoint   = "/persist";
                  mountOptions = [ "compress=zstd" "subvol=persist" "noatime" ];
                };

                "/home" = {
                  mountpoint   = "/home";
                  mountOptions = [ "compress=zstd" "subvol=home" "noatime" ];
                };

                "/nix" = {
                  mountpoint   = "/nix";
                  mountOptions = [ "compress=zstd" "subvol=nix" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
