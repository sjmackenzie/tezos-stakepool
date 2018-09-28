{ isTravis ? false
}:

let
  genJobs = path: {
    inherit (import path { configuration = ./stub-system/configuration.nix; }) system;
  };
in
genJobs <nixpkgs/nixos> // {
  oldstable = genJobs <nixos-oldstable/nixos>;
  stable = genJobs <nixos-stable/nixos>;
} // (import <nixpkgs> {}).lib.optionalAttrs isTravis {
  travisOrder = [ "system" ];
}
