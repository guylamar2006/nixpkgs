{
  lib,
  fetchFromGitHub,
  xmrig,
}:

xmrig.overrideAttrs (oldAttrs: rec {
  pname = "xmrig-mo";
  version = "6.23.0-mo1";

  src = fetchFromGitHub {
    owner = "MoneroOcean";
    repo = "xmrig";
    rev = "v${version}";
    hash = "sha256-9ne2qpN6F6FJyD/Havb7fhY1oB4AxFrB17gI7QtoE1E=";
  };

  meta = {
    description = "Fork of the XMRig CPU miner with support for algorithm switching";
    homepage = "https://github.com/MoneroOcean/xmrig";
    license = lib.licenses.gpl3Plus;
    mainProgram = "xmrig";
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [
      j0hax
      redhawk
    ];
  };
})
