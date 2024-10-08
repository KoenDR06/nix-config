{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = [
      { 
        plugin = pkgs.vimPlugins.vim-numbertoggle;
        config = "set number norelativenumber";
      }
      { plugin = pkgs.vimPlugins.vim-sleuth; }
      { 
        plugin = pkgs.vimPlugins.lualine-nvim; 
        config = lib.fileContents ./lualine.vim;
        # Change icons so that lualine looks nice in tty
      }
      { plugin = pkgs.vimPlugins.neoscroll-nvim; }
      # Save lsat cursor position
      # When in normal mode, I have to press arrow right to make a new line. Bad.
      # Clock in vim
    ];
  };
}


