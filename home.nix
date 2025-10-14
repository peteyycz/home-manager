{ config, pkgs, ... }:

{
  home.username = "peteyycz";
  home.homeDirectory = "/home/peteyycz";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    nixd
    nixfmt-rfc-style

    ghq
    fish
    starship
    mise
    helix
    zellij
  ];

  home.file = {
  };

  home.sessionVariables = {
    GOPATH = "$HOME/Code";
    GHQ_ROOT = "$GOPATH/src";
  };

  home.file.".tool-versions".source = ./.tool-versions;

  home.file.".config/zellij" = {
    source = ./zellij;
    recursive = true;
  };

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };

  programs.home-manager.enable = true;

  programs.zellij = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "067e867debee59aee231e789fc4631f80fa5788e";
          sha256 = "sha256-emmjTsqt8bdI5qpx1bAzhVACkg0MNB/uffaRjjeuFxU=";
        };
      }
    ];

    shellAliases = {
      # Git aliases
      gc = "git commit";
      gco = "git checkout";
      gp = "git push";
      gl = "git pull";
      gpf = "git push --force-with-lease";
      gst = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      gaa = "git add --all";
      grbc = "git rebase --continue";
      grba = "git rebase --abort";
      gq = "git quick";

      # Other aliases
      vim = "hx";
      l = "ls -la";
    };

    interactiveShellInit = ''
      # Set fish greeting
      set -U fish_greeting "🐟"

      # Add Go paths
      fish_add_path (go env GOBIN)
      fish_add_path "$HOME/.local/bin"

      if test -f ~/.config/fish/config.local.fish
        source ~/.config/fish/config.local.fish
      end
    '';
  };

  # Enable Starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      keys.normal = {
        y = ":clipboard-yank";
        Y = ":clipboard-yank";
        p = ":clipboard-paste-after";
        P = ":clipboard-paste-before";
      };
      keys.select = {
        y = ":clipboard-yank";
        Y = ":clipboard-yank";
      };
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        auto-format = true;
        line-number = "relative";
        whitespace = {
          render = "all";
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·";
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
            command = "nixfmt";
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
