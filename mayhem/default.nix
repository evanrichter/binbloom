{ pkgs ? import <nixpkgs> { }
}:

let
  binbloom = pkgs.binbloom.overrideAttrs (old: {
    version = "git";
    src = ../.;
    NIX_CFLAGS_COMPILE = [ "-fsanitize=address" ];
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
