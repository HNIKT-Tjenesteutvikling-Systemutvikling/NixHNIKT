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
  ./mugge.nix
  ./persist.nix
  more
]
