{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.program.vscode;
in
{
  options.program.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          # Scala/Metals
          scalameta.metals
          scala-lang.scala

          # Java essentials
          redhat.java
          vscjava.vscode-java-debug
          vscjava.vscode-java-dependency
          vscjava.vscode-java-pack

          # Nix
          jnoortheen.nix-ide

          # Formatters
          esbenp.prettier-vscode
        ];

        userSettings = {
          # Metals configuration - let it use environment JAVA_HOME
          "metals.sbtScript" = "${pkgs.sbt}/bin/sbt";

          # Nix Language Server
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nil}/bin/nil";

          # Formatters
          "prettier.prettierPath" = "${pkgs.nodePackages.prettier}/bin/prettier";
          "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";

          # Java extension configuration to use environment variables
          "java.configuration.detectJdksAtStart" = true;
          "java.configuration.runtimes" = [ ];
          "java.import.gradle.java.home" = null;
          "java.import.maven.java.home" = null;

          # Metals should use environment JAVA_HOME
          "metals.javaHome" = null;

          # Formatter configuration
          "[scala]"."editor.defaultFormatter" = "scalameta.metals";
          "[java]"."editor.defaultFormatter" = "redhat.java";
          "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
      };
    };

    home = {
      file.".config/Code/User/settings.json".enable = false;
      file.".config/Code/User/nix-system-settings.json".text = builtins.toJSON {
        # Language servers and formatters only
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "prettier.prettierPath" = "${pkgs.nodePackages.prettier}/bin/prettier";
        "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";

        # Java/Metals: use environment variables
        "java.configuration.detectJdksAtStart" = true;
        "metals.sbtScript" = "${pkgs.sbt}/bin/sbt";
        "metals.javaHome" = null;
        "java.home" = null;
      };
      activation.setupVSCodeSettings = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        SETTINGS_FILE="$HOME/.config/Code/User/settings.json"
        SYSTEM_SETTINGS="$HOME/.config/Code/User/nix-system-settings.json"

        if [ ! -f "$SETTINGS_FILE" ]; then
          cp "$SYSTEM_SETTINGS" "$SETTINGS_FILE"
        else
          ${pkgs.jq}/bin/jq -s '.[1] * .[0]' "$SYSTEM_SETTINGS" "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
          mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
        fi
      '';
      packages = with pkgs; [
        sbt
        nil
        nixpkgs-fmt
        nodePackages.prettier
        jq
      ];
    };
  };
}
