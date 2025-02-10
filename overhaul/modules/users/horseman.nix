{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.users.horseman;
in
{
  options = {
    horseman.users.horseman = {
      enable = mkEnableOption "User 'horseman'";
    };
  };

  config = mkIf cfg.enable {
    users.users = {
      horseman = {
        initialPassword = "correct horse battery staple";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtbmZFvOsukUtqKnRkzLqphpgA0HF/mCcH/6BtPah6G4v6gqu8za58w8/0//aGkurG3sfQ5YhphFMJYm26/QdCUvVYeC92LWC5mjWB/md+BOWCoZYoEL0NHuu5f+7EQcmxLYuIv7mzHB1T+fwgOyuoW6IKLLQcmokx4uyg8apUs0yaRr9rCmoxeYOlZlsE6pKS2E8YUEkCRUZ1PZW6ILHXOOaz3KQ7s429MPvKv+061SlyEZuyinzsS1+4e/j5fCddq9Ac2ar1TiIkFhmtpJfJ2iWzVAvpZ08KV4nHgews07jjuj0/dZufSXbWJI6fQCMRvETeQsDU0RB6AxO//6plSo6svsGa/XhZx55AZAotflc2EzIi5QPWa078xu8IR23/flj52gqCj3O7RxhZib+L4cCdAS8nSZkLw9VV2kROqf4JcRYsinfKetBBPJU3RYKDVq8uF23eliNw+5lYKJu5FzPVFmS/J+vAme/vHkHLNKz5CnZoABjeue4PEnpSyFCJhf4w94lbB9JBaxKuZoXvaPE7bKDTHWbVC9DKWrL+QqNP5tsiV3/jI9gx4ty9OihMv5p46ennD17AbMM6xi/yPjvX6jbDIo+jMswW1ndhH2Ka6PTRpx8G+BWgoEVjCoP/DptloE6B5EfZous8Yd+RBuRiqNk4WUB+6PWVO7ELfQ horseman" # luna
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmYI+jn1B69r4GUEeVE1/q+HSNcLzT+qG0nEpIjyO3VCsocLIJqT6cJtPKTh/j9RPySvz1lo2ZFemCeKBfsdHy95JoYqbAcoJ9jacH3X8LixIiGin6ew/h6QJONU1UAuxcEDoEyeHfmNBRdgaahNTWtgvFd1YhB4WQwN9THZ/axGdnWLi/y0y98aqERw98fGOhAzxqZyeGkWK5ByRiiGmfrmU7IsX916z5s9OPFYeIGvI3UPKL5awpQMrD/+VhtQjAy8guWbBKbN+7cVU/JQjhaPAeVC18iON++Ux6pGq1/yA+IFDb/fFofXD70vRYemg7zSVbf2ceBg8iSR2OdcZVPfhIKq7mx62TcYVY7aDlz7fFedl7tVhxRd5Ze7T/kbRQtbqL++3UQaZwnx6HoXGMvdIbKV/KHcmqjQQClzWZyk8oI+VbkF/nfTgShW/X0UQYzBSdsCb4XywzfnLRH4Ops/v7ZOc2zBApl7j1Oj+nW7dJ5/P6FgMw553tNXnEVXqGvdvalmDl/hjR3UVedm18ZKwu+6+1mcHsDGKCi5C79zVksr9IbFNICosA23xfrnKQYmncBzobbY4N39SToI9ulcukOJj26ooAG3RhHqSyOkcM3nTUbHwKb/19J+NAm2iT9ipNGurwwPO4VcJY36237es7MEkmQHfD1ZOo6biafw horseman" # terra
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrgH3kBWwxoFms9ggilPmiKX9X0/AlWjGN7a+k3ddwfK0LvH9T8ueil1Zjw16P0XNMmy076bUBJJ89aVILXgYx+ngKmnIg32lqo5bafEpub1c3wtjGcwXtJnUXMwcqdIjkR2sfzuQPLXlob/Q+GsShm4TBEtzVTdpbCj768LyTtFx4vHZByyGtam0Ibb/6GVE1V2IcA/R+iQlCAqSjFxvSq1ll+wxsEUaT7b0ru1WhUXz0ITWoRkA8p0UjTl/uoXYcsPsqGR7dXgW7hNF087TOf+FsmiL+I6pbbB8+at5yq8I6l1lCwfLaMz2M5lHkn5jZiBuUDOXWpbbk1214iWrymAbpbVmNU68QVEcQkJTnfbRQ/56Nvq80emFgke6p4vcVnR9iVbaZDnOkMVH6HEs0Qc/rC38p9aISAdJvI49GWaz8fs1OgVi7mj9xA0QREc6/oalJ1F3BehPUk8v4uqww3u+I2AdWPp/6HO9zVU2mTrO30a8IbjOqFqMqdV+nYFxNbHIIIZ9acv95FGqIBCG0U9d8XVVFQ+kVWxkXxPk0uynzAsrXyiH3gzxHwy7stCxybZkTpQPjf+vSt4Tz3PRxnyq1OWTUzWmBVe0MCdZX5h/oQp6kI1Ys/t+UrP1G9NEIwGg+/zlpmGiV8Pm10b6gEXgv09BQPFGPsBbl4NRpQQ horseman" # solis
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

    # lmao idk if I should remove this but it's funny so imma keep it
    system.stateVersion = "23.11";
  };
}
