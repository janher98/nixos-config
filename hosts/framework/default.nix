{config, pkgs, unstable, ...}:
{
  imports = [ ./hardware-configuration.nix ] ++
           ( import ../../modules/desktops/virtualisation );

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      #systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      }; 
      grub2-theme = {
        enable = true;
        theme = "tela";
        footer = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };


  hardware.opengl.enable = true; # when using QEMU KVM

  hyprland.enable = true;                       # Window Manager
#  gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [               # System-Wide Packages
      fwupd
      discord
      spotify
    ];
    etc."fwupd/uefi_capsule.conf" = pkgs.lib.mkForce {
      source = pkgs.writeText "uefi_capsule.conf" ''
      [uefi_capsule]
      OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
      DisableCapsuleUpdateOnDisk=true
      '';
    };
  };

#  flatpak = {                                   # Flatpak Packages (see module options)
#    extraPackages = [
#      "com.github.tchx84.Flatseal"
#      "com.ultimaker.cura"
#      "org.upscayl.Upscayl"
#    ];
#  };

  services = {
    fwupd = { 
      enable = true;
      extraRemotes=["lvfs-testing"];
      # enableTestRemote = true;
    };
  };

  nixpkgs.overlays = [                          # Overlay pulls latest version of Discord
    (final: prev: {
      discord = prev.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "1091nv1lwqlcs890vcil8frx6j87n4mig1xdrfxi606cxkfirfbh";
        };}
      );
    })
  ];
}

