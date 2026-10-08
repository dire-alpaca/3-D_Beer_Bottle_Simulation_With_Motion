{
  description = "3D beer bottle liquid simulation (GLEW/GLFW/GLM/stb_image)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    deps = [
      pkgs.gcc
      pkgs.glew
      pkgs.glfw
      pkgs.glm
      pkgs.stb
      pkgs.libGL
    ];

    package = pkgs.stdenv.mkDerivation {
      pname = "beer-bottle-simulation";
      version = "0.1.0";

      src = ./.;

      nativeBuildInputs = deps;

      buildPhase = ''
        g++ 3D_beer_bottle_simulation.cpp -O2 \
          -o beer_bottle_simulation -lGL -lglfw -lGLEW
      '';

      installPhase = ''
        mkdir -p $out/bin
        install -Dm755 beer_bottle_simulation $out/share/beer-bottle/beer_bottle_simulation
        install -Dm644 beer_bottle.png $out/share/beer-bottle/beer_bottle.png
        install -Dm644 broken_beer_bottle.png $out/share/beer-bottle/broken_beer_bottle.png
        cat > $out/bin/beer-bottle-simulation <<EOF
        #! /bin/sh
        cd "$out/share/beer-bottle"
        exec ./beer_bottle_simulation
        EOF
        chmod +x $out/bin/beer-bottle-simulation
      '';

      meta.mainProgram = "beer-bottle-simulation";
    };
  in {
    packages.${system}.default = package;
    devShells.${system}.default = pkgs.mkShell {
      packages = deps;
    };
    overlays.default = final: prev: {
      "${package.pname}" = package;
    };
  };
}
