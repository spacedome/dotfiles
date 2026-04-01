# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "tangerine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


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

  users.users.julien = {
    isNormalUser = true;
    description = "julien";
    extraGroups = [ "networkmanager" "wheel" ];
    # manage with home-manager
    packages = [ ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "julien";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
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
    dataDir = "/home/julien/Sync";    # Default folder for new synced folders
    configDir = "/home/julien/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

  
  # fileSystems."/mnt/nfs" = {
  #   device = "truenas-scale:/mnt/trash/julien"; 
  #   fsType = "nfs";
  #   options = [ "nfsvers=3" "nofail" ];
  # };

  # Binary Cache for Haskell.nix
  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];

  nix.settings.max-jobs=7;
  nix.settings.cores=2;


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
    FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
  programs.ssh.startAgent = true;

  system.stateVersion = "22.11"; # DO NOT CHANGE

}
