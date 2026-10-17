# Homebrew packages only installed on the personal Mac.
{ ... }:

{
  homebrew = {
    taps = [ ];

    brews = [ ];

    casks = [
      "claude"
      "t3-code"
    ];
  };
}
