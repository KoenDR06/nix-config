{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    
    extraConfig = ''
      set number relativenumber

    '';

    plugins = [
      { plugin = pkgs.vimPlugins.vim-numbertoggle; }
      { plugin = pkgs.vimPlugins.vim-sleuth; }
      { plugin = pkgs.vimPlugins.lualine-nvim; }
      { plugin = pkgs.vimPlugins.neoscroll-nvim; }
    ];
  };
}
