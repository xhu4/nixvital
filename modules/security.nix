{ config, lib, pkgs, ... }:

let cfg = config.vital.security;

in {
  options.vital.security = {
    enableFingerprint = lib.mkEnableOption "Enable fingerprint reader";
  };

  config = {
    services.keybase = {
      enable = true;
    };

    # TODO(breakds): Make this work on my envy 17 (rival).
    services.fprintd.enable = cfg.enableFingerprint;
    security.pam.services.login.fprintAuth = cfg.enableFingerprint;
    security.pam.services.xscreensaver.fprintAuth = cfg.enableFingerprint;
  };
}
