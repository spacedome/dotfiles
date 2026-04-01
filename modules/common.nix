# Shared configuration across all machines
{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  # Set your time zone. (Dynamic time zone not worth the hassle)
  # time.timeZone = "America/New_York";
  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;
  environment.plasma6.excludePackages = [ pkgs.kdePackages.baloo ];

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  services.mullvad-vpn.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Binary Cache for Haskell.nix
  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];

  environment.systemPackages = with pkgs; [
    neovim
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.telescope-nvim
    vimPlugins.telescope-fzf-native-nvim
    git
    wget
    ripgrep
    fd
    fzf
    coreutils
    alacritty
    borgbackup
    ghostty
    btop
    powertop
    tlp
    unzip
    usbutils
    xclip
    kdePackages.bluedevil
    # mullvad-vpn provided by services.mullvad-vpn.enable
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  services.syncthing = {
    enable = true;
    user = "julien";
    dataDir = "/home/julien/Sync";
    configDir = "/home/julien/.config/syncthing";
  };

  # fileSystems."/mnt/nfs" = {
  #   device = "truenas-scale:/mnt/trash/julien";
  #   fsType = "nfs";
  #   options = [ "nfsvers=3" "nofail" ];
  # };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    liberation_ttf
    eb-garamond
    jetbrains-mono
    nerd-fonts.fira-code
  ];

  environment.variables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };

  programs.ssh.startAgent = true;
}
