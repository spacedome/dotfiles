{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  # Set your time zone. (Dynamic time zone not worth the hassle)
  # time.timeZone = "America/New_York";
  time.timeZone = "America/Los_Angeles";
 

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  #boot.initrd.secrets = {
   # "/crypto_keyfile.bin" = null;
  #};

  networking.hostName = "lemon";

  nix.settings.max-jobs = 7;
  nix.settings.cores = 2;

  users.users.julien = {
    isNormalUser = true;
    description = "julien";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [ ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "julien";

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

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

  environment.systemPackages = with pkgs; [
    wget
    ripgrep
    fd
    coreutils
    borgbackup
    ghostty
    btop
    powertop
    tlp
    unzip
    usbutils
    xclip
    kdePackages.bluedevil
  ];

  services.syncthing = {
    enable = true;
    user = "julien";
    dataDir = "/home/julien/Sync";
    configDir = "/home/julien/.config/syncthing";
  };

  system.stateVersion = "22.11"; # DO NOT CHANGE
}
