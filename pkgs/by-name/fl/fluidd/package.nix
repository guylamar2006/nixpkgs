{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  replaceVars,
  nixosTests,
}:

buildNpmPackage rec {
  pname = "fluidd";
  version = "1.34.2";

  src = fetchFromGitHub {
    owner = "fluidd-core";
    repo = "fluidd";
    tag = "v${version}";
    hash = "sha256-DbuUAHsRwAiXTGjAPxT1zEcsxNloCEFLuA62/wR4+yg=";
  };

  patches = [
    (replaceVars ./hardcode-version.patch {
      inherit version;
    })
  ];

  npmDepsHash = "sha256-ZOsPUON9/bBvSrc432SGHEKKLl9ZVCq9/Nkr9Xxba/g=";

  installPhase = ''
    mkdir -p $out/share/fluidd
    cp -r dist $out/share/fluidd/htdocs
  '';

  passthru.tests = { inherit (nixosTests) fluidd; };

  meta = {
    description = "Klipper web interface";
    homepage = "https://docs.fluidd.xyz";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ zhaofengli ];
  };
}
