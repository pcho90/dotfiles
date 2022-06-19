{ config, pkgs, ... }:

let
  vscode-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "vscode-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Mofiqul";
      repo = "vscode.nvim";
      rev = "372bf0109b0949b715c2587c5dd8b011bcf50594";
      sha256 = "sha256-29XyooYcuoocyV+FdqA6On+P1XpWp8ov3IAl2m/pdII=";
    };
  };
in
{

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "peter.cho";
  home.homeDirectory = "/Users/peter.cho";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    ripgrep
    tree
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Visual Studio Dark+";
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --no-ignore-vcs --hidden";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "peter.cho";
    userEmail = "peter.cho@discordapp.com";
    extraConfig = {
      core = {
        pager = "delta";
      };
      delta = {
        enable = true;
        navigate = true;
        side-by-side = true;
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
    };
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withRuby = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      popup-nvim
      plenary-nvim
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-lspconfig
      telescope-nvim
      telescope-file-browser-nvim
      telescope-fzy-native-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lua
      nvim-web-devicons
      lualine-nvim
      trouble-nvim
      vim-commentary
      vim-surround
      vscode-nvim
      indent-blankline-nvim
    ];
    extraConfig = ''
    lua << EOF
    vim.g.mapleader = ","
    ${builtins.readFile ./nvim/options.lua}
    ${builtins.readFile ./nvim/lsp.lua}
    ${builtins.readFile ./nvim/treesitter.lua}
    ${builtins.readFile ./nvim/telescope.lua}
    ${builtins.readFile ./nvim/cmp.lua}
    ${builtins.readFile ./nvim/lualine.lua}
    ${builtins.readFile ./nvim/trouble.lua}
    ${builtins.readFile ./nvim/indent.lua}
    vim.cmd [[colorscheme vscode]]
    EOF
    hi Normal guibg=NONE ctermbg=NONE
    hi LineNr guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    ${builtins.readFile ./nvim/keymaps.vim}
    '';
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -g mouse on
    '';
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      vim-code-dark
      vim-commentary
      vim-surround
      vim-unimpaired
      vim-airline
      vim-airline-themes
      fzf-vim
      coc-nvim
    ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = builtins.readFile ./zshrc;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "vi-mode" ];
    };
  };

}
