{
  description = "leetcode-1657";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/gitignore.nix";
    };
    hly-nixpkgs.url = "github:hraban/nixpkgs/feat/lisp-packages-lite";
  };
  outputs = {
    self, nixpkgs, hly-nixpkgs, gitignore, flake-utils
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        inherit (pkgs.callPackage hly-nixpkgs {}) lispPackagesLite;
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
              lispDependencies = [ arrow-macros inferior-shell asdf str fset ];
              src = cleanSource ./.;
              meta = {
                license = "AGPLv3";
              };
            };
          };
        });
  }
