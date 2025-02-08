{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      Preferences.general.autoScroll = true;
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # Advent of Code delta-rank
        "{78b07db2-25ed-4088-9c92-5c5dcfca3c3c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/advent-of-code-delta-score/latest.xpi";
          installation_mode = "force_installed";
        };
        # SponsorBlock
        "{sponsorBlocker@ajay.app}" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
