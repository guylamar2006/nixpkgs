{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "pass-git-helper";
  version = "4.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "languitar";
    repo = "pass-git-helper";
    tag = "v${version}";
    hash = "sha256-SAMndgcxBa7wymXbOwRGcoogFfzpFFIZ0tF4NSCXpjw=";
  };

  build-system = with python3.pkgs; [ setuptools ];

  dependencies = with python3.pkgs; [ pyxdg ];

  env.HOME = "$TMPDIR";

  pythonImportsCheck = [ "passgithelper" ];

  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
    pytest-cov-stub
    pytest-mock
  ];

  meta = {
    homepage = "https://github.com/languitar/pass-git-helper";
    description = "Git credential helper interfacing with pass, the standard unix password manager";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [
      hmenke
    ];
    mainProgram = "pass-git-helper";
  };
}
