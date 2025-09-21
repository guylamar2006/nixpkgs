{
  lib,
  python3,
  fetchPypi,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "lice";
  version = "0.6";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LZU2YPdJiepaCH/TWNrtJiuyPlJP6t1+c3a2uHL0fmo=";
  };

  propagatedBuildInputs = with python3.pkgs; [ setuptools ];

  nativeCheckInputs = with python3.pkgs; [ pytestCheckHook ];

  meta = {
    description = "Print license based on selection and user options";
    homepage = "https://github.com/licenses/lice";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ swflint ];
    platforms = lib.platforms.unix;
    mainProgram = "lice";
  };

}
