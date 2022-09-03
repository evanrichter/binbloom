{ pkgs ? import <nixpkgs> { }
}:

let
  binbloom = pkgs.binbloom.overrideAttrs (old: {
    version = "git";
    src = ../.;
  });

  buildImage = pkgs.dockerTools.buildImage;
  pullImage = pkgs.dockerTools.pullImage;
in
rec {
  #debian = pullImage {
  #  imageName = "library/debian";
  #  sha256 = "0000000000000000000000000000000000000000000000000000";
  #  imageDigest = "latest";
  #};

  build = buildImage {
    name = "binbloom";
    #fromImage = debian;
    contents = [ binbloom ];
  };
}
