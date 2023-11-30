# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, unstable, inputs, vars, ... }:

{
  imports = (
    import ../modules/desktops ++
    import ../modules/editors ++
    import ../modules/programs ++
    import ../modules/services ++
    import ../modules/shell ++
    import ../modules/theming
  );

  time.timeZone = "Europe/Berlin"; # Time zone and Internationalisation
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
      LC_MONETARY = "de_DE.UTF-8";
    };
  };  
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };
  
  security = {
    polkit.enable = true; #to enable sway
    sudo.wheelNeedsPassword =  false;
  };

  fonts.packages = with pkgs; [
    carlito                                 # NixOS
    vegur                                   # NixOS
    jetbrains-mono
    source-code-pro
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera"  ]; # Enable ‘sudo’ for the user.
    initialPassword = "7353";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    variables = {                           # Environment Variables
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [           # System-Wide Packages
      # Terminal
      btop              # Resource Manager
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      nano              # Text Editor
      nix-tree          # Browse Nix Store
      pciutils          # Manage PCI
      ranger            # File Manager
      tldr              # Helper
      usbutils          # Manage USB
      wget              # Retriever
      vim 
      lshw
      

      # Video/Audio
      alsa-utils        # Audio Control
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      pipewire          # Audio Server/Control
      pulseaudio        # Audio Server/Control
      vlc               # Media Player

      # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Browser
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip

      texlive.combined.scheme-full

      vscode 
      nextcloud-client
      
      kitty
      
      (python3.withPackages(ps: with ps; [ pip dbus-python numpy ]))
      # Other Packages Found @
      # - ./<host>/default.nix
      # - ../modules
      ]++
      (with unstable; [
        # Apps
        firefox-wayland           # Browser
        fastfetch         # Neofetch replacement
      ]);
  };
  
  programs = {
    dconf.enable = true;
  };

  services = {
#    printing.enable = true;         #CUPS
    openssh = {                             # SSH
      enable = true;
#      allowSFTP = true;                     # SFTP
#      extraConfig = ''
#        HostKeyAlgorithms +ssh-rsa
#      '';
    };
  };

  flatpak.enable = true;                    # Enable Flatpak (see module options)  

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "23.05"; #dont change
  };

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = {
      stateVersion = "23.05";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}

