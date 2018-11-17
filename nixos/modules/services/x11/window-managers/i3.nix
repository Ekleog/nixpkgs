{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.windowManager.i3;
in

{
  options.services.xserver.windowManager.i3 = {
    enable = mkEnableOption "i3 window manager";

    configFile = mkOption {
      default     = null;
      type        = with types; nullOr path;
      description = ''
        Path to the i3 configuration file.
        If left at the default value, $HOME/.i3/config will be used.
      '';
    };

    extraSessionCommands = mkOption {
      default     = "";
      type        = types.lines;
      description = ''
        Shell commands executed just before i3 is started.
      '';
    };

    extraPackages = mkOption {
      type = with types; listOf package;
      default = with pkgs; [ dmenu i3status i3lock ];
      example = literalExample ''
        with pkgs; [
          dmenu
          i3status
          i3lock
        ]
      '';
      description = ''
        Extra packages to be installed system wide.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.session = [{
      name  = "i3";
      start = ''
        ${cfg.extraSessionCommands}

        ${pkgs.i3}/bin/i3 ${optionalString (cfg.configFile != null)
          "-c \"${cfg.configFile}\""
        } &
        waitPID=$!
      '';
    }];
    environment.systemPackages = [ pkgs.i3 ] ++ cfg.extraPackages;
  };

  imports = [
    (mkRemovedOptionModule [ "services" "xserver" "windowManager" "i3-gaps" "enable" ]
      "Use services.xserver.windowManager.i3.enable and set services.xserver.windowManager.i3.package to pkgs.i3-gaps to use i3-gaps.")
  ];
}
