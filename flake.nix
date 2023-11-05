{
  description = "leetcode-1657";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    cl-nix-lite.url = "github:hraban/cl-nix-lite";
  };
  outputs = {
    self, nixpkgs, cl-nix-lite, flake-utils
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend cl-nix-lite.overlays.default;
      in
      with pkgs.lispPackagesLite;
        {
          packages = {
            default = lispDerivation {
              # Trailing numbers in flake names are interpreted as version
              # numbers and stripped from the expected binary name.
              name = "leetcode";
              lispSystem = "leetcode-1657";
              lispDependencies = [ arrow-macros inferior-shell str fset ];
              src = pkgs.lib.cleanSource ./.;
              dontStrip = true;
              meta = {
                license = pkgs.lib.licenses.agpl3Only;
              };
            };
          };
        });
  }
