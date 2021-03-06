{ config, lib, pkgs, ... }:

let cfg = config.vital;

    isWeride = lib.any (x: x == "weride") cfg.machineTags;

in {
  config = lib.mkIf (cfg.mainUser == "breakds") {
    vital.desktop = {
      xserver.useCapsAsCtrl = lib.mkDefault (cfg.machineType == "laptop");
    };
    environment.systemPackages = with pkgs; [
      breakds-texlive

      # For Lisp Development
      lispPackages.quicklisp

      # Other useful packages
      wesnoth
      httpie
      gnupg
      pass
      ledger
      graphviz
      feh
      graphicsmagick
      hugo
      quickserve
      parted
      steam-run-native
    ] ++ (if isWeride then [] else [ pkgs.bazel ]);
  };
}
