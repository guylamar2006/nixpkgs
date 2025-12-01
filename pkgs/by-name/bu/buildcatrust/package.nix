{
  lib,
  fetchPypi,
  python3Packages,
}:

python3Packages.toPythonApplication (
  python3Packages.buildPythonPackage rec {
    pname = "buildcatrust";
    version = "0.4.0";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-GYw/RN1OK5fqo3em8hia2l/IwN76hnPnFuYprqeX144=";
    };

    nativeBuildInputs = [ python3Packages.flit-core ];
    nativeCheckInputs = [ python3Packages.pytestCheckHook ];

    disabledTestPaths = [
      # Non-hermetic, needs internet access (e.g. attempts to retrieve NSS store).
      "buildcatrust/tests/test_nonhermetic.py"
    ];

    pythonImportsCheck = [
      "buildcatrust"
      "buildcatrust.cli"
    ];

    meta = {
      description = "Build SSL/TLS trust stores";
      mainProgram = "buildcatrust";
      homepage = "https://github.com/lukegb/buildcatrust";
      license = lib.licenses.mit;
      maintainers = [ lib.maintainers.lukegb ];
    };
  }
)
