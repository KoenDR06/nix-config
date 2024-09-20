{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    
    extraConfig = ''
      programs.neovim.extraConfig = lib.fileContents ./init.vim;
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
