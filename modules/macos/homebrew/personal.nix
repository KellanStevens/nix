# Homebrew packages only installed on the personal Mac.
{ ... }:

{
  homebrew = {
    taps = [ ];

    brews = [ ];

    casks = [
      "claude"
      "prismlauncher"
      "t3-code"
      "signal"
    ];
  };
}
