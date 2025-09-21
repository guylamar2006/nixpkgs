{
  lib,
  python3,
  fetchPypi,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "git-annex-remote-googledrive";
  version = "1.3.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-IRufry6NGtK4W7k1TEKA/mMcOec452Dzc7T953Zjkmc=
";
  };

  build-system = with python3.pkgs; [ setuptools ];

  dependencies = with python3.pkgs; [
    annexremote
    drivelib
    gitpython
    tenacity
    humanfriendly
    distutils
  ];

  # while git-annex does come with a testremote command that *could* be used,
  # testing this special remote obviously depends on authenticating with google
  doCheck = false;

  pythonImportsCheck = [
    "git_annex_remote_googledrive"
  ];

  meta = {
    description = "Git-annex special remote for Google Drive";
    homepage = "https://github.com/Lykos153/git-annex-remote-googledrive";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ gravndal ];
    mainProgram = "git-annex-remote-googledrive";
  };
}
