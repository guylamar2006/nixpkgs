{
  lib,
  stdenv,
  fetchFromGitHub,
  attr,
  acl,
  libcap,
  liburing,
  oniguruma,
}:

stdenv.mkDerivation rec {
  pname = "bfs";
  version = "4.0.6";

  src = fetchFromGitHub {
    repo = "bfs";
    owner = "tavianator";
    rev = version;
    hash = "sha256-TXnoy+VWkS5ilW6QEtE6vd80FaJ/nIWGaeBJ/cjvquM=";
  };

  buildInputs =
    [ oniguruma ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      acl
      attr
      libcap
      liburing
    ];

  configureFlags = [ "--enable-release" ];
  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "Breadth-first version of the UNIX find command";
    longDescription = ''
      bfs is a variant of the UNIX find command that operates breadth-first rather than
      depth-first. It is otherwise intended to be compatible with many versions of find.
    '';
    homepage = "https://github.com/tavianator/bfs";
    license = lib.licenses.bsd0;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [
      yesbox
      cafkafk
    ];
    mainProgram = "bfs";
  };
}
