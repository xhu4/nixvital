{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ../nix-home
    ../modules/user.nix
    ../modules/desktop
    ../modules/web
    ../modules/deluge.nix
    ../modules/web/samba.nix
    # TODO(breakds): Bring it up
    # ../modules/web/filerun.nix
  ];

  vital.machineType = "server";

  # Machine-specific networking configuration.
  networking.hostName = "gilgamesh";
  # Generated via `head -c 8 /etc/machine-id`
  networking.hostId = "7a4bd408";

  # +----------+
  # | Desktop  |
  # +----------+

  vital.desktop = {
    enable = true;
    xserver.displayManager = "gdm";
    xserver.dpi = 100;
    nvidia = {
      # Enable this when it is no longer broken in nixos.
      enable = true;
    };
  };

  # +------------+
  # | Web Server |
  # +------------+

  vital.web = {
    enable = true;
    serveHomePage = true;
    serveFilerun = true;
    cgit = {
      enable = true;
      title = "Break's Repos.";
      servedUrl = "git.breakds.org";
      repoPath = "/home/delegator/cgits";
      syncRepo.enable = true;
    };
  };

  # +------------+
  # | WakeOnLan  |
  # +------------+

  services.wakeonlan.interfaces = [{
    interface = "eno1";
  }];

  vital.bittorrent.enable = true;
}
