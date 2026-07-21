{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      pre-commit-lib = inputs.pre-commit-hooks-nix.lib.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        name = "HNIKT-dev-shell";
        inputsFrom = [ ];
        nativeBuildInputs = with pkgs; [
          nixfmt
          nixfmt-tree
        ];
      };

      checks = {
        pre-commit-check = pre-commit-lib.run {
          src = ./../..;
          hooks = {
            statix.enable = true;
            deadnix.enable = true;
            nil.enable = true;
            nixfmt.enable = true;
            shellcheck.enable = true;
            beautysh.enable = true;
          };
        };
      };
    };
}
