{inputs, ...}: {
  imports = [inputs.android-nixpkgs.hmModule];

  nixpkgs.overlays = [inputs.android-nixpkgs.overlays.default];
  android-sdk.enable = true;

  android-sdk.packages = sdk:
    with sdk; [
      build-tools-34-0-0-rc3
      build-tools-33-0-0
      build-tools-30-0-3

      platforms-android-33
      ndk-23-1-7779620
      cmake-3-22-1

      emulator

      cmdline-tools-latest
      platform-tools
      tools
    ];
}
