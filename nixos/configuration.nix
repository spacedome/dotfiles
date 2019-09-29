

{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  system.stateVersion = "19.03";

  networking.hostName = "t470";
  #networking.hostId = "007f0100";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;



  users.users.julien = {
    uid = 1729;
    name = "julien";
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "libvirtd" "audio" "video" "systemd-journal" "networkmanager" "uucp" "sys" "adm" ];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone= "America/New_York";



  # networking.wireless.enable = true;
  # networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  sound.enable = true;
  
  hardware = {
    #bluetooth.enable = true;
    #bluetooth.powerOnBoot = false;
    #brightnessctl.enable = true;
    #cpu.intel.updateMicrocode = true;
    #opengl.enable = true;
    #opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    #trackpoint.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.enable = true;
    sane.enable = true;
  };
 
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplip ];
    startWhenNeeded = true;
  };

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    wacom.enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };
  
  services.redshift.enable = true;
  services.redshift.latitude = "42";
  services.redshift.longitude = "-72";
  services.redshift.temperature.day = 6500;
  services.redshift.temperature.night = 2500;

  nixpkgs.config.allowUnfree = true;

  fonts = {
    fontconfig.enable = true;
    enableFontDir = true;
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
      emojione
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira
      fira-code
      fira-mono
      iosevka
      hack-font
      anonymousPro
      freefont_ttf
      corefonts
      dejavu_fonts
      inconsolata
    ];
  };

  environment.systemPackages = import ./packages.nix pkgs;
}
