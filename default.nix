{ pkgs }:
{
  armcl = pkgs.callPackage ./armcl { };
  uniflash = pkgs.callPackage ./uniflash { };
}
