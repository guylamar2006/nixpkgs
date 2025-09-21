{
  lib,
  stdenv,
  python3,
  fetchFromGitHub,
  qt6Packages,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "nitrokey-app2";
  version = "2.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Nitrokey";
    repo = "nitrokey-app2";
    tag = "v${version}";
    hash = "sha256-nzhhtnKKOHA+Cw1y+BpYsyQklzkDnmFRKGIfaJ/dmaQ=";
  };

  nativeBuildInputs = with qt6Packages; [
    wrapQtAppsHook
  ];

  buildInputs =
    with qt6Packages;
    [
      qtbase
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      qtwayland
      qtsvg
    ];

  build-system = with python3.pkgs; [
    poetry-core
  ];

  dependencies = with python3.pkgs; [
    fido2
    nitrokey
    pyside6
    usb-monitor
  ];

  pythonRelaxDeps = [ "nitrokey" ];

  pythonImportsCheck = [
    "nitrokeyapp"
  ];

  postInstall = ''
    install -Dm755 meta/com.nitrokey.nitrokey-app2.desktop $out/share/applications/com.nitrokey.nitrokey-app2.desktop
    install -Dm755 meta/nk-app2.png $out/share/icons/hicolor/128x128/apps/com.nitrokey.nitrokey-app2.png
  '';

  # wrapQtApps only wrapps binary files and normally skips python programs.
  # Manually pass the qtWrapperArgs from wrapQtAppsHook to wrap python programs.
  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  meta = {
    description = "This application allows to manage Nitrokey 3 devices";
    homepage = "https://github.com/Nitrokey/nitrokey-app2";
    changelog = "https://github.com/Nitrokey/nitrokey-app2/releases/tag/${src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      _999eagle
      panicgh
    ];
    mainProgram = "nitrokeyapp";
  };
}
