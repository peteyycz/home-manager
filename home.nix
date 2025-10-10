{ config, pkgs, ... }:

{
  home.username = "peteyycz";
  home.homeDirectory = "/home/peteyycz";

  home.stateVersion = "25.05";

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.helix
    pkgs.mise
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        auto-format = true; # Enable auto-formatting on save
        line-number = "relative";
        whitespace = {
          render = "all"; # Shows all whitespace characters
          characters = {
            space = "·"; # Middle dot for spaces
            nbsp = "⍽"; # Non-breaking space
            tab = "→"; # Right arrow for tabs
            newline = "⏎"; # Return symbol for newlines
            tabpad = "·"; # Padding for tabs
          };
        };
      };

    };

    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt"; # or nixpkgs-fmt
            args = [ ];
          };
          language-servers = [ "nixd" ];
        }
      ];
    };
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      legacy_version_file = true;
    };
  };
}
