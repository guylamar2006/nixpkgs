{
  lib,
  fetchFromGitHub,
  python3,
}:

python3.pkgs.buildPythonApplication {
  pname = "scfbuild";
  version = "2.0.0";

  format = "other";

  src = fetchFromGitHub {
    owner = "13rac1";
    repo = "scfbuild";
    rev = "6d84339512a892972185d894704efa67dd82e87a";
    hash = "sha256-TcFFlmRrpjcX0q9iDLJbKtmD9guE2Np2Tl1RqOH8fnI=";
  };

  dependencies = with python3.pkgs; [
    pyyaml
    fonttools
    fontforge
    setuptools
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/${python3.sitePackages}
    cp -r scfbuild $out/${python3.sitePackages}
    cp -r bin $out

    runHook postInstall
  '';

  meta = {
    description = "SVGinOT color font builder";
    homepage = "https://github.com/13rac1/scfbuild";
    license = lib.licenses.gpl3;
    maintainers = [ ];
    mainProgram = "scfbuild";
  };
}
