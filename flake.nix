{
  description = "leetcode-1657";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/gitignore.nix";
    };
    cl-nix-lite = {
      flake = false;
      url = "github:hraban/cl-nix-lite";
    };
  };
  outputs = {
    self, nixpkgs, cl-nix-lite, gitignore, flake-utils
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        lispPackagesLite = import cl-nix-lite { inherit pkgs; };
      in
      with lispPackagesLite;
        {
          packages = {
            default = lispDerivation {
              # Trailing numbers in flake names are interpreted as version
              # numbers and stripped from the expected binary name.
              name = "leetcode";
              lispSystem = "leetcode-1657";
              buildInputs = [ pkgs.sbcl ];
              lispDependencies = [ arrow-macros inferior-shell str fset ];
              src = cleanSource ./.;
              dontStrip = true;
              meta = {
                license = pkgs.lib.licenses.agpl3Only;
              };
            };
          };
        });
  }
