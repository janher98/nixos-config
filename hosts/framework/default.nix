{config, pkgs, stable, ...}:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  imports = [ ./hardware-configuration.nix
              ./disko.nix] ++
           ( import ../../modules/desktops/virtualisation );

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      #systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/efi";
      };
      timeout = 2;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "module_blacklist=hid_sensor_hub" ];
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };


  hardware.graphics.enable = true; # when using QEMU KVM

  hyprland.enable = true;                       # Window Manager
  #gnome.enable = true;
  #virtualbox.enable = true;

  environment = {
    systemPackages = with pkgs; [               # System-Wide Packages
      fwupd
      spotify
      gnucash
      #gnome.gnome-keyring
      #gnome.seahorse
      libsecret
      #polkit
      #texlive.combined.scheme-full

      vscode
      nextcloud-client

      kitty
      nautilus

      prismlauncher

      #firefox-wayland           # Browser
      thunderbird
      anki-bin
    ] ++ (with stable; [
      # Apps
      discord
#      firefox-wayland           # Browser
#      thunderbird
      #fastfetch         # Neofetch replacement
    ]);
  };

#  flatpak = {                                   # Flatpak Packages (see module options)
#    extraPackages = [
#      "com.github.tchx84.Flatseal"
#      "com.ultimaker.cura"
#      "org.upscayl.Upscayl"
#    ];
#  };
#
  flatpak.enable = true;                    # Enable Flatpak (see module options)

  services = {
    fwupd = {
      enable = true;
      # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
      package = (import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
        sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
      }) {
        inherit (pkgs) system;
      }).fwupd;
    };
    #gnome = {
    #  gnome-keyring.enable = true;
    #};
  };
  #security.pam.services.gnomekey.enableGnomeKeyring = true;


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
