{ lib, ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = 
    let
      normalVisual =
        lib.mapAttrsToList
        (key: action: {
          mode = [ "n" "v" ];
          inherit action key;
        })
        {
          # show terminal
          "<C-\\>" = "<cmd>ToggleTerm<CR>";

          # hop!
          "f" = "<cmd>HopWord<CR>";

          # Setup for custom keybinds
          ";" = "<NOP>";
          "<space>" = "<NOP>";
        
          # Telescope
          "<space>f" = "<cmd>Telescope find_files<CR>";
          "<space>b" = "<cmd>Telescope buffers<CR>";
          "<space>d" = "<cmd>Telescope lsp_definitions<CR>";
          "<space>R" = "<cmd>Telescope lsp_references<CR>";
          "<space>e" = "<cmd>Telescope file_browser<CR>";
          "<space>c" = "<cmd>Telescope git_bcommits<CR>";
          "<space>g" = "<cmd>Telescope git_status<CR>";
          
          # Lsp
          "<space>a" = "<cmd>lua vim.lsp.buf.code_action()<CR>";
          "<space>D" = "<cmd>lua vim.lsp.buf.declaration()<CR>";
          "<space>h" = "<cmd>lua vim.lsp.buf.hover()<CR>";
          "<space>r" = "<cmd>lua vim.lsp.buf.rename()<CR>";
          "<space>o" = "<cmd>lua vim.diagnostic.open_float()<CR>";
          "<space>l" = "<cmd>lua require('lsp_lines').toggle()<CR>";

          # Debugger
          "<F5>" = "<cmd>lua require('dap').continue()<CR>";
          "<F8>" = "<cmd>lua require('dap').terminate()<CR>";
          "<F10>" = "<cmd>lua require('dap').step_over()<CR>";
          "<F11>" = "<cmd>lua require('dap').step_into()<CR>";
          "<F12>" = "<cmd>lua require('dap').step_out()<CR>";
          ";d" = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
          ";s" = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";

          # Competitest
          ";r" = "<cmd>CompetiTest receive problem<CR>";
          ";t" = "<cmd>CompetiTest run<CR>";
          ";a" = "<cmd>CompetiTest add_testcase<CR>";
          ";e" = "<cmd>CompetiTest edit_testcase<CR>";
          ";l" = "<cmd>CompetiTest delete_testcase<CR>";
          ";c" = "<cmd>CompetiTest convert auto<CR>";

          # resize windows with arrows
          "<C-Up>"    = "<cmd>resize -2<CR>";
          "<C-Down>"  = "<cmd>resize +2<CR>";
          "<C-Left>"  = "<cmd>vertical resize +2<CR>";
          "<C-Right>" = "<cmd>vertical resize -2<CR>";


          # TODO: make shortcuts for diffview
          # or use telescope to view git stuff
        };
      vni =
        lib.mapAttrsToList
        (key: action: {
          mode = [ "n" "v" "i" ];
          inherit action key;
        })
        {
          # copy, cut, paste
          # TODO: why does pasting work but not copying in visual mode???
          "<CS-c>" = "\\\"+y";
          "<CS-x>" = "\\\"+c";
          "<CS-v>" = "\\\"+p";

          # saving
          "<C-s>" = "<cmd>w<CR>";
        };
      in
        normalVisual ++ vni;
  };
}
