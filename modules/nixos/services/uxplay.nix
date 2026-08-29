{ pkgs, ... }:

{
  systemd.user.services.uxplay = {
    description = "UxPlay AirPlay Receiver";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      ExecStart = "${pkgs.uxplay}/bin/uxplay -p -fs -nofreeze -reset 3 -hls -as 0 -nc no -fps 60 -s 1920x1080";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
