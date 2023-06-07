{ config, fetchurl, stdenv, pkgs }:
let
  version = "8.1.1.4146";
in
stdenv.mkDerivation rec {
  pname = "uniflash";
  inherit version;

  src = fetchurl {
    url = "https://dr-download.ti.com/software-development/software-programming-tool/MD-QeJBJLj8gq/8.1.1/uniflash_sl.${version}.run";
    sha256 = "sha256-U4IueKp2HotWo0DFHPpqnnudvHD2KjmfxKe6fcdSwyU=";
    executable = true;
  };

  dontConfigure = true;
  dontBuild = true;
  dontUnpack = true;
  dontPatch = true;
  nativeBuildInputs = [
    stdenv.cc
    pkgs.autoPatchelfHook
    pkgs.libxcrypt-legacy
    pkgs.libusb-compat-0_1
    pkgs.udev
    pkgs.zlib
  ];

  installPhase = ''
    runHook preInstall

    $(cat $NIX_CC/nix-support/dynamic-linker) $src --prefix $out --unattendedmodeui none --mode unattended
    rm -rf $out/node-webkit
    # rm -rf $out/simplelink
    # rm -rf $out/docs
    # rm -rf $out/deskdb/content/TICloudAgent/n
    rm $out/uniflash_install.log
    rm $out/uninstall.dat
    rm $out/uninstall
    rm $out/uniFlashGUI.sh
    rm $out/UniFlash.desktop
    rm $out/autoupdate-linux-x64.run
    mkdir $out/bin
    ln -s $out/dslite.sh $out/bin/DSLite

    runHook postInstall
  '';
}
