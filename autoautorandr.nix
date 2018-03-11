let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          autoautorandr = haskellPackagesNew.callPackage ./default.nix { };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
  { 
    autoautorandr = pkgs.haskellPackages.autoautorandr;
  }
