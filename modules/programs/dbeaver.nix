{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.dbeaver;

  dbeaverWrapped =
    pkgs.runCommand "dbeaver-wrapped"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        mkdir -p $out/bin
        makeWrapper ${pkgs.dbeaver-bin}/bin/dbeaver $out/bin/dbeaver \
          --set JAVA_HOME "${cfg.javaPackage.home}" \
          --prefix PATH : "${cfg.javaPackage}/bin"
      '';
in
{
  options.program.dbeaver = {
    enable = lib.mkEnableOption "dbeaver";

    javaPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk21;
      description = "Java package to use with DBeaver";
    };

    xmx = lib.mkOption {
      type = lib.types.str;
      default = "1024m";
      description = "Maximum memory allocation for DBeaver";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ dbeaverWrapped ];
      persistence."/persist/${config.home.homeDirectory}" = {
        directories = [
          ".local/share/DBeaverData"
        ];
      };
    };
  };
}
