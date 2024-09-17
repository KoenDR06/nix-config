{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../pkgs/zsh.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    dotnetCorePackages.sdk_9_0
  ];

  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Amsterdam";

  services.lorri.enable = true;

  services.tailscale.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/home/horseman/.ssh/id_ed25519" ];
      keyFile = "/home/horseman/.config/sops/age/keys.txt";
      generateKey = false;
    };
    secrets = {
      "syncthing/luna".owner = "horseman";
      "syncthing/terra".owner = "horseman";
      "syncthing/solis".owner = "horseman";
    };
    templates = {
      "syncluna".content = ''${config.sops.placeholder."syncthing/luna"}'';
      "syncterra".content = ''${config.sops.placeholder."syncthing/terra"}'';
      "syncsolis".content = ''${config.sops.placeholder."syncthing/solis"}''; 
    };
  };

  services.syncthing = {
    enable = true;
    user = "horseman";
    dataDir = "/home/horseman";
    configDir = "/home/horseman/.config/syncthing";
    overrideDevices = false;
    overrideFolders = true;
    settings = {
      devices = {
        "luna" = { id = config.sops.templates."syncluna".content; };
        "terra" = { id = config.sops.templates."syncterra".content; };
        "solis" = { id = config.sops.templates."syncsolis".content; };
      };
      folders = {
        "Documents" = {
          path = "/home/horseman/Documents";
          devices = [ "luna" "terra" "solis" ];
        };
        "Programming" = {
          path = "/home/horseman/Programming";
          devices = [ "luna" "terra" "solis" ];
        };
      };
    };
  };

  users.users = {
    horseman = {
      initialPassword = "1234";
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [
        ../../config/ssh/authorized_keys
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "23.11";
}
