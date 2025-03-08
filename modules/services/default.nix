let
  more = {
    services = {
      flameshot.enable = true;
    };
  };
in [
  ./network.nix
  ./secret.nix
  more
]
