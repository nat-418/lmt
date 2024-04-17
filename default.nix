{ pkgs ? import <nixpkgs> {} }:

{
  lmt = pkgs.callPackage ./package.nix {};
}
