# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, user, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    
  };




  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
    #  LC_ADDRESS = "de_DE.UTF-8";
    #  LC_IDENTIFICATION = "de_DE.UTF-8";
    #  LC_MEASUREMENT = "de_DE.UTF-8";
    #  LC_NAME = "de_DE.UTF-8";
    #  LC_NUMERIC = "de_DE.UTF-8";
    #  LC_PAPER = "de_DE.UTF-8";
    #  LC_TELEPHONE = "de_DE.UTF-8";
    #  LC_MONETARY = "de_DE.UTF-8";
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services = {
    xserver = {
    #  layout = "de";
    #  libinput.enable = true;
    #  enable = true;
      displayManager = {
        gdm = {
           enable = true;
           wayland = true;
        };
    #    defaultSession = "gnome";
      };
    #  desktopManager.gnome.enable = true;
    };
    fwupd = { 
      enable = true;
      extraRemotes=["lvfs-testing"];
      # enableTestRemote = true;
    };
    flatpak.enable = true;
  };
  programs.hyprland.enable = true;
  
  security.polkit.enable = true; #to enable sway
  #programs.light.enable = true; #to make sway use light keys

  fonts.packages = with pkgs; [
    source-code-pro
    font-awesome
    corefonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];
  
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ]; # Enable ‘sudo’ for the user.
    initialPassword = "7353";
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    lshw
    firefox
    git 
    texlive.combined.scheme-full
    podman-compose
    neofetch
    starship
    nextcloud-client
    spotify
    distrobox
    discord
    (python3.withPackages(ps: with ps; [ pip dbus-python numpy ]))
  ];

  virtualisation = {
    podman = {
      enable = true;
      #rootless = {
       # enable = true;
       # setSocketVariable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
#      containers = {
#        container-name = {
#          image = "stuff";
#          autostart = true;
#          ports = [ "127.0.0.1:1234:1234"];
#        };
#      };
    };
#    virtualbox = {
#      host = {
#        enable = true;
#        enableExtensionPack = true;
#      };
#      guest = {
#        enable = true;
#        x11 = true;
#      };
#    };
  };

  environment.etc."fwupd/uefi_capsule.conf" = pkgs.lib.mkForce {
    source = pkgs.writeText "uefi_capsule.conf" ''
      [uefi_capsule]
      OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
      DisableCapsuleUpdateOnDisk=true
    '';
  };
  
  nixpkgs.config.allowUnfree = true;

  security = {
    sudo.wheelNeedsPassword =  false;
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

