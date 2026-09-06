{ config, pkgs, ... }:

let
  # WayDroid-ATV OTA channels (https://github.com/WayDroid-ATV).
  # "a16-tv" is Android TV 16 on LineageOS 23.0. Use "a13-tv" for Android TV 13.
  # waydroid appends "/<rom_type>/waydroid_<arch>/<system_type>.json" to the
  # system channel, and "/waydroid_<arch>/MAINLINE.json" to the vendor channel.
  otaChannel = "https://waydroid-atv.github.io/ota/a16-tv";

  waydroid-atv-init = pkgs.writeShellScriptBin "waydroid-atv-init" ''
    set -eu
    exec ${config.virtualisation.waydroid.package}/bin/waydroid init \
      -c "${otaChannel}/system" \
      -v "${otaChannel}/vendor" \
      -r lineage \
      -s GAPPS \
      "$@"
  '';
in
{
  # Android container. This enables LXC, the binder gbinder config, the
  # waydroid-container service, and firewall trust for the waydroid0 bridge.
  virtualisation.waydroid.enable = true;

  # Install the images once with `sudo waydroid-atv-init`. Add -f to re-download.
  # Later updates only need `sudo waydroid upgrade`.
  environment.systemPackages = [ waydroid-atv-init ];
}
