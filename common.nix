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

  github-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "github-nvim";

    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "81c6a906845b150bb5b51c9979e290e9874efff1";
      sha256 = "sha256-T8heB2axjPABuyoU33lFFArbbKB4gNgJDv13rOWzYvI=";
    };

    buildInputs = [ pkgs.luajitPackages.luacheck ];
  };

  catppuccin-vim = pkgs.vimUtils.buildVimPlugin {
    name = "catppuccin-vim";

    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "vim";
      rev = "ee1c14bd00fd6edcf158fab340c42622690fd859";
      sha256 = "sha256-wLn72cGtVA080e+oGSidUfCBfZCRvcGX6K9c5qJT7xQ=";
    };

    buildInputs = [ pkgs.luajitPackages.luacheck ];
  };
in {
  imports = [ ./hosts/${host.name}.nix ] ++ (if isDarwin then [ ./darwin.nix ] else [ ]);

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
      nodePackages.typescript-language-server
      openssh
      ripgrep
      tree
      python310Packages.flake8
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "Catppuccin";
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
          syntax-theme = "Catppuccin";
        };

        interactive.diffFilter = "delta --color-only";
      };
    };

    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        vscode-nvim
        gruvbox
        popup-nvim
        plenary-nvim
        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
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
        lualine-nvim
        trouble-nvim
        vim-commentary
        vim-unimpaired
        vim-surround
        vim-flake8
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
        EOF
        colorscheme catppuccin
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
        catppuccin-vim
        gruvbox
        vim-code-dark
        vim-commentary
        vim-surround
        vim-unimpaired
        lightline-vim
        fzf-vim
        coc-nvim
        vim-flake8
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
