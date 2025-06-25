{
  lib,
  stdenv,
  rpm,
  cpio,
  replaceVarsWith,
}:

stdenv.mkDerivation {
  name = "rpmextract";

  buildCommand = ''
    install -Dm755 $script $out/bin/rpmextract
  '';

  script = replaceVarsWith {
    src = ./rpmextract.sh;
    isExecutable = true;
    replacements = {
      inherit rpm cpio;
      inherit (stdenv) shell;
    };
  };

  meta = with lib; {
    description = "Script to extract RPM archives";
    platforms = lib.platforms.all;
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ abbradar ];
    mainProgram = "rpmextract";
  };
}
