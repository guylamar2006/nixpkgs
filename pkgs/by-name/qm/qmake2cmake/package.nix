{
  lib,
  python3,
  fetchgit,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "qmake2cmake";
  version = "1.0.6";
  format = "setuptools";

  src = fetchgit {
    url = "https://codereview.qt-project.org/qt/qmake2cmake";
    tag = "v${version}";
    hash = "sha256-M5XVQ8MXo2Yxg5eZCho2YAGFtB0h++mEAg8NcQVuP/w=";
  };

  patches = [
    ./fix-locations.patch
  ];

  dependencies = with python3.pkgs; [
    packaging
    platformdirs
    portalocker
    pyparsing
    sympy
  ];

  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = {
    description = "Tool to convert qmake .pro files to CMakeLists.txt";
    homepage = "https://wiki.qt.io/Qmake2cmake";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ wegank ];
  };
}
