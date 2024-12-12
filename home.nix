{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "julien";
  home.homeDirectory = "/home/julien";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    anki
    jq
    p7zip
    imagemagick
    firefox
    helix
    jetbrains-mono
    krita
    mpv
    digikam
    ispell
    graphviz
    nil # nix lsp
    nixd # nix lsp
    signal-desktop
    smplayer
    zathura
    zotero
    # qbittorrent-qt5
    hlint
    ormolu
    ghc
    cabal-install
    ghc
    stack
    haskell-language-server
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
    epkgs.vterm epkgs.pdf-tools epkgs.emacsql-sqlite
    ]))
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.nh.enable = true;
  programs.nh.flake = ./.;

  programs.git = {
    enable = true;
    userName = "spacedome";
    userEmail = "spacedome@users.noreply.github.com";
  };
  programs.git.difftastic.enable = true;
  programs.lazygit.enable = true;
  programs.helix.defaultEditor = true;

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  

  programs.mpv.enable = true;
  programs.mpv.config = {
    loop = true;
    directory-mode = "recursive";
  };
  programs.mpv.bindings = {
    "ctrl+r" = "cycle_values video-rotate 90 180 270 0";
    "Alt+k" = ''playlist-shuffle ; show-text ''${playlist} 4000'';
  };

  programs.nushell.enable = true;
  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.tmux.enableShellIntegration = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/julien/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
