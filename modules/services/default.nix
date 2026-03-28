let
  more = {
    services = {
      flameshot.enable = true;
    };
  };
in
[
  ./dconf.nix
  ./easyeffect.nix
  ./gpg.nix
  ./network.nix
  ./persist.nix
  more
]
