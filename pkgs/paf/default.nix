{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  wineWow64Packages,
}:

let
  wine = wineWow64Packages.wayland;
in
stdenv.mkDerivation rec {
  pname = "paf";
  version = "5.2";

  src = fetchurl {
    url = "https://archive.org/download/PAF5EnglishSetup/PAF5EnglishSetup.exe";
    hash = "sha256-NFNN8gma9gaT3YfWpTUWFUsLEVWxgMRJIHcnfZLqi3w=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ wine ];

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
    # NOTE: wineWow64Packages does not support WINEARCH=win32.
    # It is pure 64-bit Wine that runs 32-bit Windows apps via wow64
    # inside a 64-bit prefix, so we must NOT set WINEARCH=win32 here.
    export PATH="${wine}/bin:\$PATH"

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
