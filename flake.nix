{
  description = "Box3D rigid-body physics library";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = nixpkgs.lib.intersectLists nixpkgs.lib.systems.flakeExposed [
        "x86_64-linux" "aarch64-darwin" "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      buildBox3d = system: test:
        let pkgs = import nixpkgs { inherit system; };
        in pkgs.stdenv.mkDerivation {
          pname = "box3d";
          version = "0.1.0";
          src = self;
          nativeBuildInputs = with pkgs; [ cmake ninja ];
          cmakeBuildType = if test then "Debug" else "Release";
          cmakeFlags = [
            "-DBOX3D_SAMPLES=OFF"
            "-DBOX3D_UNIT_TESTS=${if test then "ON" else "OFF"}"
          ];
          postConfigure = ''
            grep -Fxq "CMAKE_PROJECT_VERSION:STATIC=$version" CMakeCache.txt
          '';
          doCheck = test;
          checkPhase = ''
            runHook preCheck
            ./bin/test
            runHook postCheck
          '';
        };
    in {
      packages = forAllSystems (system: { default = buildBox3d system false; });
      checks = forAllSystems (system: { unit-tests = buildBox3d system true; });
    };
}
