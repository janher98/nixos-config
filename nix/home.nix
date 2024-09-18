{ config, pkgs, stable, inputs, ...}:
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    #kitty
  ];

  gtk.font = {                               # Fonts
    package = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };
  nix = {
    settings.auto-optimise-store = true;
    package = pkgs.nixVersions.git;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;
}
