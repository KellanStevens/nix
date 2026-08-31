{ lib, pkgs, ... }:

let
  remoteControlScript =
    name: directory:
    pkgs.writeShellScript "claude-remote-control-${name}" ''
      ${pkgs.coreutils}/bin/mkdir -p "$HOME/${directory}"
      cd "$HOME/${directory}"
      exec ${pkgs.claude-code}/bin/claude remote-control --name ${lib.escapeShellArg name}
    '';

  remoteControlService = name: directory: {
    description = "Claude Remote Control for ${name}";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${remoteControlScript name directory}";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
in
{
  systemd.user.services = {
    claude-remote-control-nix = remoteControlService "nix" "nix";
    claude-remote-control-claude = remoteControlService "claude" "claude";
  };
}
