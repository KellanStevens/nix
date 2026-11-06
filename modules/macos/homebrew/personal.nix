# Homebrew packages only installed on the personal Mac.
{ ... }:

{
  homebrew = {
    taps = [ ];

    brews = [ ];

    casks = [
      "claude"
      "codex"
      "prismlauncher"
      "t3-code@nightly"
      "signal"
    ];
  };
}
