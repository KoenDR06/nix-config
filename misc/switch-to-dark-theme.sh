#!/bin/sh

lookandfeeltool -a org.kde.breezedark.desktop

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
var allDesktops = desktops();
for (i = 0; i < allDesktops.length; i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = "org.kde.image";
    d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
    d.writeConfig("Image", "file:///home/horseman/nix-config/misc/nixos_wallpaper_dark_3840x2160.png");
}'
