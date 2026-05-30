{ stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation {
  pname = "arc-midnight-cursors";
  version = "unstable-2024";

  src = fetchzip {
    url = "https://github.com/yeyushengfan258/ArcMidnight-Cursors/archive/refs/heads/main.tar.gz";
    hash = "sha256-VgOpt0rukW0+rSkLFoF9O0xO/qgwieAchAev1vjaqPE=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/ArcMidnight-Cursors
    cp -r dist/cursors $out/share/icons/ArcMidnight-Cursors/
    cp dist/index.theme $out/share/icons/ArcMidnight-Cursors/
  '';
}
