{
  lib,
  fetchPypi,
  python3,
  gobject-introspection,
  wrapGAppsNoGuiHook,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "gnome-extensions-cli";
  version = "0.10.6";
  format = "pyproject";

  src = fetchPypi {
    pname = "gnome_extensions_cli";
    inherit version;
    hash = "sha256-REsdgsHPYBms+qbOF4ogV8D/xi5fC9ogl+HOvnsXi7o=";
  };

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsNoGuiHook
  ]
  ++ (with python3.pkgs; [
    poetry-core
  ]);

  pythonRelaxDeps = [
    "more-itertools"
    "packaging"
  ];

  dependencies = with python3.pkgs; [
    colorama
    packaging
    pydantic
    requests
    pygobject3
    tqdm
  ];

  pythonImportsCheck = [
    "gnome_extensions_cli"
  ];

  meta = {
    homepage = "https://github.com/essembeh/gnome-extensions-cli";
    description = "Command line tool to manage your GNOME Shell extensions";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ dylanmtaylor ];
    platforms = lib.platforms.linux;
  };
}
