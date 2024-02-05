{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    forester.url = "sourcehut:~jonsterling/ocaml-forester";
  };
  outputs =
    { nixpkgs
    , flake-utils
    , forester
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        #legacyPackages = import forester.legacyPackages.${system};
      in
      {
        devShells = {
          default = pkgs.mkShell {
            packages = [
              forester.packages.${system}.default
              pkgs.texlive.combined.scheme-full
              pkgs.fswatch
              pkgs.python312
            ];
          };
          build = pkgs.mkShell {
            packages = [
              forester.packages.${system}.default
              pkgs.texlive.combined.scheme-full
              pkgs.fswatch
            ];
          };
        };
      });
}
