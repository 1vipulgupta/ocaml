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
            { packages.default = 
              # pkgs.mkShell { #create a new shell with hook > compiles main.rs as run ./main
              #                                   buildInputs =  with pkgs; [ coreutils dune_3 gzip ocaml ocamlPackages.cppo ocamlPackages.ounit2 node2nix gnutar gcc 
              #                               nodejs opam git gnutar clang gnumake python3 re2c gcc ocamlformat
              #                             ];
              #                                   inputsFrom = [ ];
              #                                   shellHook = ''
              #                                   '';
              #                                 };
              
              pkgs.stdenv.mkDerivation {
                pname = "rescript-compiler";
                version = "10.1.4";
                builder = [./builder.sh];
                system = builtins.currentSystem;
                buildInputs = with pkgs; [ coreutils dune_3 gzip ocaml ocamlPackages.cppo ocamlPackages.opam-repository node2nix gnutar gcc 
                                            nodejs opam git gnutar clang gnumake python3 re2c gcc ocamlformat ocamlPackages.findlib
                                          ];
                src = ./rescript-compiler.tar.gz;
              };

            });
}