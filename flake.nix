{
  description = "PureScript dev environment.";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            purescript
            spago
            nodejs
            git
          ];
          
          shellHook = ''
            echo "PureScript dev environment."
            echo "PureScript version: $(purs --version)"
            echo "Spago version: $(spago --version)"
            echo "Node.js version: $(node --version)"
          '';
        };
      }
    );
}
