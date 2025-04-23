let
  more = {
    services = {
      flameshot.enable = true;
    };
  };
in
[
  ./dconf.nix
  ./gpg.nix
  ./network.nix
  more
]
