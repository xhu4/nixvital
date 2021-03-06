# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=[this-nix-file]

{config, pkgs, ...}:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    # Start the installer service in the background.
    ../modules/services/nixvital-web-installer.nix
  ];

  # Disable wayland.
  services.xserver.displayManager.gdm.wayland = false;
  
  environment.systemPackages = with pkgs; [
    vim emacs firefox git
  ];
}
