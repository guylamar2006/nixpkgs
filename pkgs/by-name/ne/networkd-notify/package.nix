{
  lib,
  fetchFromGitLab,
  python3,
  systemd,
  wirelesstools,
  wrapGAppsNoGuiHook,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "networkd-notify";
  version = "unstable-2025-03-15";
  # There is no setup.py, just a single Python script.
  format = "other";

  src = fetchFromGitLab {
    owner = "wavexx";
    repo = "networkd-notify";
    rev = "5d3425bb24fe4b5e34167707b185840dd96acffd";
    hash = "sha256-4nDYcdnI9R3oBxjGRaGX7QQMlApHwN7Hd0Y6TEMlF4Y=";
  };

  nativeBuildInputs = with python3.pkgs; [
    wrapGAppsNoGuiHook
  ];

  propagatedBuildInputs = with python3.pkgs; [
    dbus-python
    pygobject3
  ];

  patchPhase = ''
    sed -i \
      -e '/^NETWORKCTL = /c\NETWORKCTL = ["${systemd}/bin/networkctl"]' \
      -e '/^IWCONFIG = /c\IWCONFIG = ["${wirelesstools}/bin/iwconfig"]' \
      networkd-notify
  '';

  dontBuild = true;

  installPhase = ''
    install -D networkd-notify -t "$out/bin/"
    install -D -m0644 networkd-notify.desktop -t "$out/share/applications/"
  '';

  # Let the Python wrapper add gappsWrapperArgs, to avoid two layers of wrapping.
  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = {
    description = "Desktop notification integration for systemd-networkd";
    mainProgram = "networkd-notify";
    homepage = "https://gitlab.com/wavexx/networkd-notify";
    maintainers = with lib.maintainers; [ danc86 ];
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
