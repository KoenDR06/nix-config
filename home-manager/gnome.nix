{
  pkgs,
  ...
}: {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
        "spotify.desktop"
        "virt-manager.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    # "org/gnome/wm/keybindings/toggle-maximized" = {
    # ['<Super>Up']  
    # };
  };
}
