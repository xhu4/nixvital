{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../../nix-home/cassandra
    ../../modules/user.nix
    ../../modules/desktop
    ../../modules/web
    ../../modules/dev/vscode.nix
  ];

  vital.machineType = "desktop";

  # +----------+
  # | Desktop  |
  # +----------+

  vital.desktop = {
    enable = true;
    xserver.displayManager = "gdm";
    xserver.dpi = 100;
    nvidia = {
      enable = true;
      withCuda = false;
    };
  };

  # +----------+
  # | Extras   |
  # +----------+

  environment.systemPackages = with pkgs; [
    gimp peek gnupg pass libreoffice
  ];

  # +------------+
  # | WakeOnLan  |
  # +------------+

  services.wakeonlan.interfaces = [{
    interface = "eno1";
  }];
}