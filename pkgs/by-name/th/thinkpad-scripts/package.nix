{
  lib,
  fetchFromGitHub,
  python3,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "thinkpad-scripts";
  version = "4.12.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "martin-ueding";
    repo = "thinkpad-scripts";
    tag = "v${version}";
    hash = "sha256-foraZWLYV/Rg+TcKy3atAwhXqCBeQeXs+orzWzLqTSE=";
  };

  dependencies = with python3.pkgs; [ setuptools ];

  meta = {
    description = "Screen rotation, docking and other scripts for ThinkPad® X220 and X230 Tablet";
    homepage = "https://github.com/martin-ueding/thinkpad-scripts";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ dawidsowa ];
  };
}
