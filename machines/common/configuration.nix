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
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtbmZFvOsukUtqKnRkzLqphpgA0HF/mCcH/6BtPah6G4v6gqu8za58w8/0//aGkurG3sfQ5YhphFMJYm26/QdCUvVYeC92LWC5mjWB/md+BOWCoZYoEL0NHuu5f+7EQcmxLYuIv7mzHB1T+fwgOyuoW6IKLLQcmokx4uyg8apUs0yaRr9rCmoxeYOlZlsE6pKS2E8YUEkCRUZ1PZW6ILHXOOaz3KQ7s429MPvKv+061SlyEZuyinzsS1+4e/j5fCddq9Ac2ar1TiIkFhmtpJfJ2iWzVAvpZ08KV4nHgews07jjuj0/dZufSXbWJI6fQCMRvETeQsDU0RB6AxO//6plSo6svsGa/XhZx55AZAotflc2EzIi5QPWa078xu8IR23/flj52gqCj3O7RxhZib+L4cCdAS8nSZkLw9VV2kROqf4JcRYsinfKetBBPJU3RYKDVq8uF23eliNw+5lYKJu5FzPVFmS/J+vAme/vHkHLNKz5CnZoABjeue4PEnpSyFCJhf4w94lbB9JBaxKuZoXvaPE7bKDTHWbVC9DKWrL+QqNP5tsiV3/jI9gx4ty9OihMv5p46ennD17AbMM6xi/yPjvX6jbDIo+jMswW1ndhH2Ka6PTRpx8G+BWgoEVjCoP/DptloE6B5EfZous8Yd+RBuRiqNk4WUB+6PWVO7ELfQ= horseman@luna"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrgH3kBWwxoFms9ggilPmiKX9X0/AlWjGN7a+k3ddwfK0LvH9T8ueil1Zjw16P0XNMmy076bUBJJ89aVILXgYx+ngKmnIg32lqo5bafEpub1c3wtjGcwXtJnUXMwcqdIjkR2sfzuQPLXlob/Q+GsShm4TBEtzVTdpbCj768LyTtFx4vHZByyGtam0Ibb/6GVE1V2IcA/R+iQlCAqSjFxvSq1ll+wxsEUaT7b0ru1WhUXz0ITWoRkA8p0UjTl/uoXYcsPsqGR7dXgW7hNF087TOf+FsmiL+I6pbbB8+at5yq8I6l1lCwfLaMz2M5lHkn5jZiBuUDOXWpbbk1214iWrymAbpbVmNU68QVEcQkJTnfbRQ/56Nvq80emFgke6p4vcVnR9iVbaZDnOkMVH6HEs0Qc/rC38p9aISAdJvI49GWaz8fs1OgVi7mj9xA0QREc6/oalJ1F3BehPUk8v4uqww3u+I2AdWPp/6HO9zVU2mTrO30a8IbjOqFqMqdV+nYFxNbHIIIZ9acv95FGqIBCG0U9d8XVVFQ+kVWxkXxPk0uynzAsrXyiH3gzxHwy7stCxybZkTpQPjf+vSt4Tz3PRxnyq1OWTUzWmBVe0MCdZX5h/oQp6kI1Ys/t+UrP1G9NEIwGg+/zlpmGiV8Pm10b6gEXgv09BQPFGPsBbl4NRpQQ= horseman@solis"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmYI+jn1B69r4GUEeVE1/q+HSNcLzT+qG0nEpIjyO3VCsocLIJqT6cJtPKTh/j9RPySvz1lo2ZFemCeKBfsdHy95JoYqbAcoJ9jacH3X8LixIiGin6ew/h6QJONU1UAuxcEDoEyeHfmNBRdgaahNTWtgvFd1YhB4WQwN9THZ/axGdnWLi/y0y98aqERw98fGOhAzxqZyeGkWK5ByRiiGmfrmU7IsX916z5s9OPFYeIGvI3UPKL5awpQMrD/+VhtQjAy8guWbBKbN+7cVU/JQjhaPAeVC18iON++Ux6pGq1/yA+IFDb/fFofXD70vRYemg7zSVbf2ceBg8iSR2OdcZVPfhIKq7mx62TcYVY7aDlz7fFedl7tVhxRd5Ze7T/kbRQtbqL++3UQaZwnx6HoXGMvdIbKV/KHcmqjQQClzWZyk8oI+VbkF/nfTgShW/X0UQYzBSdsCb4XywzfnLRH4Ops/v7ZOc2zBApl7j1Oj+nW7dJ5/P6FgMw553tNXnEVXqGvdvalmDl/hjR3UVedm18ZKwu+6+1mcHsDGKCi5C79zVksr9IbFNICosA23xfrnKQYmncBzobbY4N39SToI9ulcukOJj26ooAG3RhHqSyOkcM3nTUbHwKb/19J+NAm2iT9ipNGurwwPO4VcJY36237es7MEkmQHfD1ZOo6biafw= horseman@terra"
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
