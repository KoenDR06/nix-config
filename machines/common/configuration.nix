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

  nix.settings.trusted-users = [ "root" "horseman" ];
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
      "syncthing/user".owner = "horseman";
      "syncthing/password".owner = "horseman";
    };
    templates = {
      "syncuser".content = ''${config.sops.placeholder."syncthing/user"}''; 
      "syncpassword".content = ''${config.sops.placeholder."syncthing/password"}'';       
    };
  };

  services.syncthing = {
    enable = true;
    user = "horseman";
    dataDir = "/home/horseman";
    configDir = "/home/horseman/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      options = {
        urAccepted = -1;
      }
      gui = {
        user = config.sops.templates."syncuser".content;
        password = config.sops.templates."syncpassword".content;
      };
      devices = {
        "luna" = {
          id = "MW4ZTAX-D7KDLRL-YHNGNCF-V6FW5L4-SCKQKES-BO7KV43-L5667GL-JHIYEAA";
          autoAcceptFolders = true;
          name = "luna";
        };
        "terra" = {
          id = "2QWRFLY-ZUY5C6C-X36R5CY-PJSGLYY-5HWIWJN-2YYWRPU-T66GJMU-GXTQ6QK";
          autoAcceptFolders = true;
          name = "terra";
        };
        "solis" = {
          id = "TI3T3BI-7TPOMUM-CWOL3M5-QBHTBVD-EX2DQVC-62UHHA3-JTUSN5F-5S47JQD";
          autoAcceptFolders = true;
          name = "solis";
        };
      };
      folders = {
        "Documents" = {
          id = "documentFolder";
          path = "/home/horseman/Documents";
          devices = [ "luna" "terra" "solis" ];
        };
      };
    };
  };
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];

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
