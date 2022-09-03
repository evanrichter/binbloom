{ pkgs ? import <nixpkgs> { }
}:

let
  binbloom = pkgs.binbloom.overrideAttrs (old: {
    version = "git";
    src = ../.;
  });

  buildImage = pkgs.dockerTools.buildImage;
in

rec {
  build = buildImage {
    name = "binbloom";
    tag = "latest";
    created = "now";
    copyToRoot = [ binbloom ];
  };
}
