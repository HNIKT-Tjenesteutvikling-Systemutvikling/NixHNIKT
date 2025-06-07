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
      package = pkgs.vscode.fhs;
      mutableExtensionsDir = true;
      profiles.default = {
        # Extensions are managed by Nix - users can still install additional ones
        extensions = with pkgs.vscode-extensions; [
          # Copilot
          github.copilot
          github.copilot-chat

          # Editor
          editorconfig.editorconfig
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh

          # Scala/Metals
          scalameta.metals
          scala-lang.scala

          # Java essentials
          redhat.java
          vscjava.vscode-java-debug
          vscjava.vscode-java-dependency
          vscjava.vscode-java-pack

          # Kotlin
          mathiasfrohlich.kotlin

          # Nix
          bbenoist.nix
          jnoortheen.nix-ide

          # Yaml/Markdown
          bierner.github-markdown-preview
          bierner.markdown-checkbox
          bierner.markdown-emoji
          bierner.markdown-footnotes
          bierner.markdown-mermaid
          bierner.markdown-preview-github-styles

          # Javascript/CSS
          vue.volar
          bradlc.vscode-tailwindcss

          # Formatters
          esbenp.prettier-vscode
        ];

        # Don't manage userSettings
        userSettings = { };
      };
    };

    home = {
      file.".config/Code/User/nix-defaults.json" = {
        text = builtins.toJSON {
          # Performance improvements for Scala/Metals
          "files.watcherExclude" = {
            "**/.bloop" = true;
            "**/.metals" = true;
            "**/.ammonite" = true;
          };

          # Git improvements
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;

          # Editor improvements
          "workbench.tree.indent" = 20;
          "workbench.startupEditor" = "none";
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = true;
          "editor.minimap.enabled" = false;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";

          # Code lens for better navigation
          "java.referencesCodeLens.enabled" = true;
          "java.implementationsCodeLens.enabled" = true;
          "typescript.implementationsCodeLens.enabled" = true;
          "typescript.referencesCodeLens.enabled" = true;
          "typescript.referencesCodeLens.showOnAllFunctions" = true;

          # File type associations
          "files.associations" = {
            "*.kt" = "gradle-kotlin-dsl";
            "*.css" = "tailwindcss";
          };

          # Auto-import improvements
          "javascript.updateImportsOnFileMove.enabled" = "always";
          "typescript.updateImportsOnFileMove.enabled" = "always";

          # UX improvements
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "diffEditor.ignoreTrimWhitespace" = false;
          "security.workspace.trust.untrustedFiles" = "open";

          # Metals configuration - let it use environment JAVA_HOME
          "metals.sbtScript" = "${pkgs.sbt}/bin/sbt";
          "metals.javaHome" = null;

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

          # Docker
          "docker.dockerPath" = "${pkgs.docker}/bin/docker";

          # Remote SSH
          "remote.SSH.path" = "${pkgs.openssh}/bin/ssh";
          "remote.SSH.configFile" = "~/.ssh/config";

          # Markdown configuration
          "markdown.preview.fontSize" = 14;
          "markdown.preview.lineHeight" = 1.6;

          # Vue/JavaScript configuration
          "vue.server.petiteVue.supportHtmlFile" = true;
          "typescript.preferences.includePackageJsonAutoImports" = "auto";
          "javascript.preferences.includePackageJsonAutoImports" = "auto";

          # EditorConfig
          "editorconfig.generateAuto" = false;

          # TailwindCSS configuration
          "tailwindCSS.includeLanguages" = {
            "html" = "html";
            "javascript" = "javascript";
            "typescript" = "typescript";
            "vue" = "vue";
            "scala" = "html";
          };
          "tailwindCSS.experimental.classRegex" = [
            "class:\\s*?[\"'`]([^\"'`]*.*?)[\"'`]"
            "className:\\s*?[\"'`]([^\"'`]*.*?)[\"'`]"
          ];

          # Formatter configuration
          "[scala]"."editor.defaultFormatter" = "scalameta.metals";
          "[java]"."editor.defaultFormatter" = "redhat.java";
          "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
          "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[vue]"."editor.defaultFormatter" = "vue.volar";
          "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[yaml]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };

      # Initialize settings.json only if it doesn't exist
      activation.initializeVSCodeSettings = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        SETTINGS_FILE="$HOME/.config/Code/User/settings.json"
        NIX_DEFAULTS="$HOME/.config/Code/User/nix-defaults.json"

        # Only initialize if settings.json doesn't exist
        if [ ! -f "$SETTINGS_FILE" ]; then
          echo "Initializing VS Code settings with Nix defaults..."
          cp "$NIX_DEFAULTS" "$SETTINGS_FILE"
        fi
      '';

      packages = with pkgs; [
        # Build tools
        sbt

        # Language servers and formatters
        nil
        nixpkgs-fmt
        nodePackages.prettier

        # JavaScript/TypeScript ecosystem
        nodejs_20
        nodePackages.typescript

        # Utilities
        jq
      ];
    };
  };
}
