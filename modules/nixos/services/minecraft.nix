{ pkgs, ... }:

let
  # nixpkgs is on build 223; pin the newer stable build.
  paper = pkgs.papermc.overrideAttrs (_: {
    version = "26.3-244";
    src = pkgs.fetchurl {
      url = "https://fill-data.papermc.io/v1/objects/9601f9a26a2a52a0f2c807cf1abf691f96ee4fb287878313b601cebc2c51eabf/paper-26.3-244.jar";
      hash = "sha256-lgH5omoqUqDyyAfPGr9pH5buT7KHh4MTtgHOvCxR6r8=";
    };
  });

  heap = "6G";

  # Aikar's flags: https://docs.papermc.io/paper/aikars-flags
  jvmFlags = [
    "-Xms${heap}"
    "-Xmx${heap}"
    "--add-modules=jdk.incubator.vector"
    "-XX:+UseG1GC"
    "-XX:+ParallelRefProcEnabled"
    "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions"
    "-XX:+DisableExplicitGC"
    "-XX:+AlwaysPreTouch"
    "-XX:G1NewSizePercent=30"
    "-XX:G1MaxNewSizePercent=40"
    "-XX:G1HeapRegionSize=8M"
    "-XX:G1ReservePercent=20"
    "-XX:G1HeapWastePercent=5"
    "-XX:G1MixedGCCountTarget=4"
    "-XX:InitiatingHeapOccupancyPercent=15"
    "-XX:G1MixedGCLiveThresholdPercent=90"
    "-XX:G1RSetUpdatingPauseTimePercent=5"
    "-XX:SurvivorRatio=32"
    "-XX:+PerfDisableSharedMem"
    "-XX:MaxTenuringThreshold=1"
    "-Dusing.aikars.flags=https://mcflags.emc.gs"
    "-Daikars.new.flags=true"
  ];
in
{
  services.minecraft-server = {
    enable = true;
    package = paper;

    # Accepting the Minecraft EULA: https://aka.ms/MinecraftEULA
    eula = true;
    openFirewall = true;

    declarative = true;

    jvmOpts = builtins.concatStringsSep " " jvmFlags;

    serverProperties = {
      server-port = 25565;
      motd = "slim";
      max-players = 20;
      difficulty = "normal";
      gamemode = "survival";
      online-mode = true;

      view-distance = 12;
      simulation-distance = 8;

      network-compression-threshold = 256;
    };
  };
}
