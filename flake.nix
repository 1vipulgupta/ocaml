{
    description = "Basic flake with mkDerivation";
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs";
        };
        flake-utils = { url = "github:numtide/flake-utils"; };
    };
    outputs = {self, nixpkgs, flake-utils, ...}:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
            ocamlPackages = pkgs.ocamlPackages;
            in
            { packages.default = ocamlPackages.buildDunePackage {
                pname = "rescript-compiler";
                version = "10.1.4";

                src = pkgs.fetchurl {
                  url = "https://github.com/rescript-lang/rescript-compiler/archive/refs/tags/10.1.4.tar.gz";
                  sha256 = "sha256-ka10RuKqWIiYrpaOSLd6JfpGbaUKkchYTGV0Ez+QWMA=";
                };

                duneVersion = "3";

                strictDeps = true;

                preBuild = ''
                  dune build rescript.opam
                '';
              };
            });
}