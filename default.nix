{ stdenv, lib, patches ? [] }:
stdenv.mkDerivation {
  name = "sfm";
  src = ./.;
  version = "0.3.1";
  inherit patches;
  buildPhase = ''
  make sfm;
  '';
  installPhase = ''
  mkdir -p $out/bin;
  mkdir -p $out/share/man;
  make PREFIX=$out install;
  '';
  meta.license = lib.licenses.isc;
}
