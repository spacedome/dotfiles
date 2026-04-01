# Machine-specific configuration for tangerine
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "tangerine";

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

  system.stateVersion = "22.11"; # DO NOT CHANGE
}
