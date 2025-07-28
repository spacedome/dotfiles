{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "julien";
  home.homeDirectory = "/home/julien";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  imports = [ inputs.zen-browser.homeModules.beta ];

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
    brave
    claude-code
    helix
    krita
    mpv
    digikam
    ispell
    graphviz
    nil # nix lsp
    nixd # nix lsp
    signal-desktop
    mcomix
    smplayer
    pcsx2
    zathura
    zotero
    qbittorrent
    hlint
    ormolu
    ghc
    cabal-install
    ghc
    stack
    haskell-language-server
    cabal2nix
    direnv
    gh # github cli
    #fonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    liberation_ttf
    eb-garamond
    jetbrains-mono
    nerd-fonts.fira-code
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.emacsql
    ];
  };

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
  programs.nh.flake = "/home/julien/dotfiles";

  programs.git = {
    enable = true;
    userName = "spacedome";
    userEmail = "spacedome@users.noreply.github.com";
  };
  programs.git.difftastic.enable = true;
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

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true; # save webs for later reading
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = {
        "wappalyzer@crunchlabz.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi";
          installation_mode = "force_installed";
        };
        "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/github-file-icons/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden_password_manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences =
        let
          locked = value: {
            "Value" = value;
            "Status" = "locked";
          };
        in
        {
          "browser.tabs.warnOnClose" = locked false;
        };
    };
  };

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
