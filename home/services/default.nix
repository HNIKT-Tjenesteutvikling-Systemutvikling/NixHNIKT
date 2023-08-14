let
  more = {
    services = {
      flameshot.enable = true;
    };
  };
in [
  ./secret.nix
  more
]
