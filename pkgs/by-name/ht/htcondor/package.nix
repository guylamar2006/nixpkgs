{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  libuuid,
  expat,
  curl,
  pcre2,
  sqlite,
  python3,
  boost,
  libxml2,
  libvirt,
  munge,
  voms,
  perl,
  scitokens-cpp,
  openssl,
}:

stdenv.mkDerivation rec {
  pname = "htcondor";
  version = "24.12.4";

  src = fetchFromGitHub {
    owner = "htcondor";
    repo = "htcondor";

    rev = "v${version}";
    hash = "sha256-3yhKtqp8vqi1NyazBEeDbanoKezFp6jK2/KtCJXaMo8=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    libuuid
    expat
    openssl
    curl
    pcre2
    sqlite
    python3
    boost
    libxml2
    libvirt
    munge
    voms
    perl
    scitokens-cpp
  ];

  env.CXXFLAGS = "-fpermissive";

  cmakeFlags = [
    "-DSYSTEM_NAME=NixOS"
    "-DWITH_PYTHON_BINDINGS=false"
  ];

  meta = with lib; {
    homepage = "https://htcondor.org/";
    description = "Software system that creates a High-Throughput Computing (HTC) environment";
    platforms = platforms.linux;
    license = licenses.asl20;
    maintainers = with maintainers; [ evey ];
    # On Aarch64: ld: cannot find -lpthread: No such file or directory
    # On x86_64:  ld: cannot find -ldl:      No such file or directory
    broken = true;
  };
}
