{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  winePackages,
  winetricks,
}:

let
  wine = winePackages.full;
in
stdenv.mkDerivation rec {
  pname = "paf";
  version = "5.2";

  src = fetchurl {
    url = "https://archive.org/download/PAF5EnglishSetup/PAF5EnglishSetup.exe";
    hash = "sha256-NFNN8gma9gaT3YfWpTUWFUsLEVWxgMRJIHcnfZLqi3w=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    wine
    winetricks
  ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/opt/${pname}
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons

    cp $src $out/opt/${pname}/PAF5EnglishSetup.exe

    cat > $out/bin/paf << EOF
    #!/usr/bin/env bash
    export WINEPREFIX="\$HOME/.wine-paf"
    # PAF 5.2 uses an old InstallShield bootstrapper that spawns a 16-bit
    # kernel.exe stub. wine64/wow64-only builds drop the 16-bit subsystem,
    # so we need a 32-bit prefix with winePackages.full.
    export WINEARCH=win32
    export PATH="${wine}/bin:${winetricks}/bin:\$PATH"

    if [ -f "\$WINEPREFIX/system.reg" ] && grep -q '^#arch=win64' "\$WINEPREFIX/system.reg"; then
      echo "Error: \$WINEPREFIX is a 64-bit prefix, but PAF needs win32." >&2
      echo "Remove it (rm -rf \$WINEPREFIX) and run paf again to reinstall." >&2
      exit 1
    fi

    PAF_EXE="\$WINEPREFIX/drive_c/Program Files (x86)/PAF5/PAF.exe"
    PAF_EXE_ALT="\$WINEPREFIX/drive_c/Program Files/PAF5/PAF.exe"

    if [ ! -f "\$PAF_EXE" ] && [ ! -f "\$PAF_EXE_ALT" ]; then
      echo "First run: installing Personal Ancestral File into \$WINEPREFIX ..."
      wineboot --init
      wine "$out/opt/${pname}/PAF5EnglishSetup.exe"
      echo "Installation complete. Launching PAF..."
    fi

    if [ -f "\$PAF_EXE" ]; then
      exec wine "\$PAF_EXE"
    else
      exec wine "\$PAF_EXE_ALT"
    fi
    EOF

    chmod +x $out/bin/paf

    cat > $out/share/applications/paf.desktop << EOF
    [Desktop Entry]
    Name=Personal Ancestral File
    Comment=Genealogy software by FamilySearch
    Exec=paf
    Icon=paf
    Type=Application
    Categories=Education;
    EOF
  '';

  meta = {
    description = "Personal Ancestral File (PAF) 5.2 genealogy software by FamilySearch, running via Wine";
    homepage = "https://www.familysearch.org";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ Gako358 ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "paf";
  };
}
