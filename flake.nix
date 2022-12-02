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
        pkgs = import nixpkgs { inherit system; };
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        inherit (pkgs.callPackage hly-nixpkgs {}) lispPackagesLite;
      in
      with lispPackagesLite;
        {
          packages = {
            default = lispDerivation {
              lispSystem = "leetcode-1657";
              buildInputs = [ pkgs.sbcl ];
              lispDependencies = [ arrow-macros inferior-shell asdf str fset ];
              src = cleanSource ./.;
              installPhase = ''
                mkdir -p "$out/bin"
                cp dist/leetcode-1657 "$out/bin/"
              '';
              meta = {
                license = "AGPLv3";
              };
            };
          };
        });
  }
