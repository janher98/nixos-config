{pkgs, ...}: 
let
  vim-roam = pkgs.vimUtils.buildVimPlugin {
    name = "vim-roam";
    src = pkgs.fetchFromGitHub {
      owner = "jeffmm";
      repo = "vim-roam";
      rev = "ea2c687a708e06005b477402f28c4a3f86b9417e";
      sha256 = "sha256-cidF+oSHbtfn5ihIIkxTanvrsZF8fhIRcL75xou8A6Y=";
    };
  };
  wikivim = pkgs.vimUtils.buildVimPlugin {
    name = "vim-roam";
    src = pkgs.fetchFromGitHub {
      owner = "lervag";
      repo = "wiki.vim";
      rev = "e38c0ae3612165f18a4d2176898e6fface0651b1";
      sha256 = "sha256-L/ft8e5EvV0vKHwTEMADIeRPhprcU8rbR2Qp3iomCTc=";
    };
  };
in{
  programs.nixvim = {
    extraPlugins = [
      #vim-roam
      wikivim
      #pkgs.vimPlugins.fzf
      ];
  };
}

