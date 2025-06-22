{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "tweeny";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "mobius3";
    repo = "tweeny";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-VmvOMK+FjYZXKH9kPUT2L7pmJMPSr5eXptCcoGWK+qo=";
  };

  nativeBuildInputs = [
    cmake
  ];

  doCheck = true;

  meta = {
    description = "Modern C++ tweening library";
    license = lib.licenses.mit;
    homepage = "http://mobius3.github.io/tweeny";
    maintainers = with lib.maintainers; [ doronbehar ];
    platforms = with platforms; darwin ++ linux;
  };
})
