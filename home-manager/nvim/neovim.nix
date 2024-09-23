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
      }
      { plugin = pkgs.vimPlugins.neoscroll-nvim; }
    ];
  };
}


