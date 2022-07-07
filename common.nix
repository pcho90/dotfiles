{ pkgs, host, homeDirectory, isDarwin, ... }:

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
in {
  imports = [ ./hosts/${host.name}.nix ]
    ++ (if isDarwin then [ ./darwin.nix ] else [ ]);

  home = {
    inherit (host) username;
    inherit homeDirectory;

    packages = with pkgs; [
      curl
      delta
      deno
      fd
      htop
      jq
      nodePackages.pyright
      openssh
      ripgrep
      tree
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    git = {
      enable = true;
      userName = "pcho90";

      extraConfig = {
        core.pager = "delta";
        fetch.prune = true;
        merge.conflictStyle = "diff3";

        pull = {
          rebase = true;
          ff = "only";
        };

        delta = {
          enable = true;
          navigate = true;
          side-by-side = true;
          syntax-theme = "OneHalfDark";
        };

        interactive.diffFilter = "delta --color-only";
      };
    };

    neovim = {
      enable = true;
      withPython3 = true;
      withRuby = true;
      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
        vscode-nvim
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
        indent-blankline-nvim
      ];

      extraConfig = ''
        let mapleader = ","
        lua << EOF
        ${builtins.readFile ./config/nvim/options.lua}
        ${builtins.readFile ./config/nvim/lsp.lua}
        ${builtins.readFile ./config/nvim/treesitter.lua}
        ${builtins.readFile ./config/nvim/telescope.lua}
        ${builtins.readFile ./config/nvim/cmp.lua}
        ${builtins.readFile ./config/nvim/lualine.lua}
        ${builtins.readFile ./config/nvim/trouble.lua}
        ${builtins.readFile ./config/nvim/indent.lua}
        EOF
        colorscheme vscode
        hi Normal guibg=NONE ctermbg=NONE
        hi LineNr guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi EndOfBuffer guibg=NONE ctermbg=NONE
        ${builtins.readFile ./config/nvim/keymaps.vim}
      '';
    };

    ssh.enable = true;

    tmux = {
      enable = true;
      keyMode = "vi";
      terminal = "xterm-256color";

      extraConfig = ''
        set-option -g mouse on
      '';
    };

    vim = {
      enable = true;
      extraConfig = builtins.readFile ./config/vimrc;

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

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      initExtra = builtins.readFile ./config/zshrc;

      envExtra = builtins.readFile ./config/zshenv;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" "vi-mode" ];
      };
    };

    fzf = {
      enable = true;
      defaultCommand = "rg --files --no-ignore-vcs --hidden";
    };
  };
}
