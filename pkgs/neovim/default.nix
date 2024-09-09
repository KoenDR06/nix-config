{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./language.nix
    ./running.nix
    ./shortcuts.nix
  ];

  home.packages = [
    # used by telescope find_files and file_browser
    pkgs.fd
  ];

  # adds and configures neovim using
  # https://github.com/nix-community/nixvim
  # todo: git, zooming in and out,
  # better indentation,
  # latex, competative programming, ...
  
  # These are some misc thingies
  programs.nixvim = {
    enable = true;

    withRuby = false;
    
    colorschemes.onedark = {
      enable = true;
      settings.style = "darker";
    };
    
    clipboard = {
      providers.wl-copy.enable = true;
    };

    opts = {
      relativenumber = true;
      number = true; # Display the absolute line number of the current line

      expandtab = true;
      autoindent = true;
      shiftwidth = 4;
      tabstop = 4;
    };

    # TODO Should be removed when upgrading from 24.05,
    # see ./language.nix, plugins.lsp.inlayHints
    package = (import inputs.nixos-unstable { inherit (pkgs) system; }).neovim-unwrapped;

    # TODO enable performance stuff once upgrading 24.05

    plugins = {
      lualine.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      diffview.enable = true;
      neoscroll.enable = true;
      gitsigns.enable = true;
      hop.enable = true;

      # Does not exist yet?
      # guess-indent.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          size = 15;
        };
      };

      telescope = {
        enable = true;

        extensions = {
          # better selection ui, used for code actions
          ui-select.enable = true;
          fzf-native.enable = true;
          file-browser = {
            enable = true;
            settings.hijack_netrw = true;
          };
        };
      };

    };
  };
}
