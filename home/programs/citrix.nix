{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.citrix;

  extraCerts = [];
  citrixOverlay = self: super: {
    citrix_workspace = super.citrix_workspace.overrideAttrs (oldAttrs: rec {
      inherit extraCerts;
      buildInputs = oldAttrs.buildInputs ++ [self.openssl];
      postInstall = ''
        mkdir -p $out/opt/Citrix/ICAClient/keystore/cacerts
        for cert in ${lib.concatStringsSep " " extraCerts}; do
          certName=$(basename "''${cert}" .pem)
          ${self.openssl}/bin/openssl x509 -in "''${cert}" -out "$certName.crt" -outform DER
          cp "''${certName}.crt" $out/opt/Citrix/ICAClient/keystore/cacerts/
        done
      '';
    });
  };

  citrix_workspace = pkgs.citrix_workspace.override {
    libvorbis = pkgs.libvorbis.override {
      libogg = pkgs.libogg.overrideAttrs (prevAttrs: {
        cmakeFlags =
          (prevAttrs.cmakeFlags or [])
          ++ [
            (lib.cmakeBool "BUILD_SHARED_LIBS" true)
          ];
      });
    };
  };
in {
  options.citrix.enable = lib.mkEnableOption "citrix";

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = [citrixOverlay];
    home.packages = [
      citrix_workspace
    ];
  };
}
