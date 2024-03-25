{
  pkgs,
  ...
}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
      locate-pointer = true;
    };
    
    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Photos.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Calendar.desktop"
      ];
      sort-order = [
        "org.gnome.Settings.desktop"
        "org.gnome.Documents.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Characters.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calendar.desktop" 
        "org.gnome.clocks.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Photos.desktop"
      ];
    };
    
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 3;
    };
      
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "spotify.desktop"
        "com.github.eneshecan.WhatsAppForLinux.desktop"
        "discord.desktop"
      ];
      enabled-extensions = [
        "just-perfection-desktop@just-perfection"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      ];
    };
        
    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      app-menu = false;
      app-menu-label = false;
      ripple-box = false;
      windows-demands-attention-focus = true;
      switcher-popup-delay = true;
      animation = 5;
      alt-tab-small-icon-size = 64;
      alt-tab-window-preview-size = 256;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "com.github.eneshecan.WhatsAppForLinux.desktop:2"
        "discord.desktop:2"
        "spotify.desktop:2"
        "parsecd.desktop:3"
      ];
    };
      
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
    };
    
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = false;
      center-new-windows = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
      clock-show-weekday = true;
      clock-show-seconds = true;
      show-weekdate = true;
    };

    "org/gnome/shell/extensions/window-list" = {
      show-on-all-monitors = true;
    };

    # Keybindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = ["<Super>t"];
      command = "kgx";
      name = "Console";
    };
    
    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
      minimize = ["<Super>Down"];
      toggle-maximized = ["<Super>Up"];
      close = ["<Alt>F4"];
      panel-run-dialog = ["<Alt>F2"];
      switch-to-workspace-left = ["<Control><Super>Left"];
      switch-to-workspace-right = ["<Control><Super>Right"];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Super>l"];
      home = ["<Super>e"];
    };
    
    "org/gnome/shell/keybindings" = {
      screenshot = ["Print"];
      show-screenshot-ui = ["<Shift><Super>s"];
      toggle-message-tray = ["<Super>v"];
    };
    
    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = "@as []";
    };
  };
}

