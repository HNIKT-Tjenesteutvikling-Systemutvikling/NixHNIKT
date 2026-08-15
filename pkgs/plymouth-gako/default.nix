{
  lib,
  stdenvNoCC,
  imagemagick,
  promptY ? "0.70",
}:

stdenvNoCC.mkDerivation {
  pname = "plymouth-theme-gako";
  version = "1";

  src = ./.;

  nativeBuildInputs = [ imagemagick ];

  dontConfigure = true;

  # Authored at 3x the 1080p reference size so the script can scale them down
  # per display and stay sharp. PNG32 forces RGBA; ImageMagick otherwise emits
  # grayscale for these single-hue assets, which loses the alpha channel.
  buildPhase = ''
    runHook preBuild

    magick -size 48x48 xc:none -fill '#CBCBCB' \
      -draw 'circle 23.5,23.5 23.5,0.5' PNG32:bullet.png
    magick -size 2580x450 xc:none -fill '#1A1A1AD9' \
      -draw 'roundrectangle 0,0 2579,449 54,54' PNG32:panel.png

    substituteInPlace gako.script --replace-fail '@promptY@' '${promptY}'

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    themeDir=$out/share/plymouth/themes/gako
    install -Dm444 gako.png -t $themeDir
    install -Dm444 gako.script -t $themeDir
    install -Dm444 bullet.png -t $themeDir
    install -Dm444 panel.png -t $themeDir

    # The NixOS plymouth module rewrites any /nix/store/*/share/plymouth/themes
    # path in here to the initrd location, so these must stay absolute.
    cat > $themeDir/gako.plymouth <<EOF
    [Plymouth Theme]
    Name=gako
    Description=Full-bleed gako splash with a LUKS passphrase prompt
    ModuleName=script

    [script]
    ImageDir=$themeDir
    ScriptFile=$themeDir/gako.script
    EOF

    runHook postInstall
  '';

  meta = {
    description = "Plymouth boot splash built around gako.png";
    platforms = lib.platforms.linux;
  };
}
