{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "julien";
  home.homeDirectory = "/home/julien";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05"; # Do not change

  home.packages = with pkgs; [
    anki
    jq
    p7zip
    imagemagick
    firefox
    brave
    # claude-code
    # prefer : nix profile install github:sadjow/claude-code-nix
    # update : nix profile update '.*claude.*'
    helix
    krita
    mpv
    digikam
    ispell
    graphviz
    nixd
    signal-desktop
    mcomix
    smplayer
    obsidian
    julia
    dua
    pcsx2
    zathura
    zotero
    qbittorrent
    hlint
    ormolu
    ghc
    cabal-install
    stack
    haskell-language-server
    cabal2nix
    direnv
    nix-output-monitor
    gh # github cli
  ] ++ [
    inputs.helium.packages.${system}.default
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.emacsql
    ];
  };

  home.file = {
    # currently none
  };

  programs.nh.enable = true;
  programs.nh.flake = "/home/julien/dotfiles";

  programs.git = {
    enable = true;
    settings.user.name = "spacedome";
    settings.user.email = "spacedome@users.noreply.github.com";
  };
  programs.difftastic.enable = true;
  programs.lazygit.enable = true;
  programs.helix.defaultEditor = true;

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


  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
