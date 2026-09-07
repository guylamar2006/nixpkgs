{
  copyDesktopItems,
  fetchFromGitHub,
  fetchpatch,
  git,
  glibmm,
  gst_all_1,
  kdePackages,
  lib,
  libarchive,
  makeDesktopItem,
  pipewire,
  pkg-config,
  pulseaudio,
  stdenv,
  usePipewire ? true,
  usePulseaudio ? false,
}:

assert lib.asserts.assertMsg (
  usePipewire != usePulseaudio
) "You need to enable one and only one of pulseaudio or pipewire support";

stdenv.mkDerivation (finalAttrs: {
  pname = "jamesdsp";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "Audio4Linux";
    repo = "JDSP4Linux";
    fetchSubmodules = true;
    tag = finalAttrs.version;
    hash = "sha256-eVndqIqJ3DRceuFMT++g2riXq0CL5r+TWbvzvaYIfZ8=";
  };

  strictDeps = true;
  __structuredAttrs = true;

  nativeBuildInputs = [
    kdePackages.qmake
    pkg-config
    copyDesktopItems
    kdePackages.wrapQtAppsHook
    git
  ];

  patches = [
    (fetchpatch {
      url = "https://github.com/Audio4Linux/JDSP4Linux/pull/241.patch";
      hash = "sha256-RtVKlw2ca8An4FodeD0RN95z9yHDHBgAxsEwLAmW7co=";
      name = "fix-build-with-new-pipewire.patch";
    })
    ./fix-build-on-qt6_9.diff
  ];

  buildInputs = [
    glibmm
    libarchive
    kdePackages.qtbase
    kdePackages.qtsvg
    kdePackages.qtwayland
  ]
  ++ lib.optionals usePipewire [
    pipewire
  ]
  ++ lib.optionals usePulseaudio [
    pulseaudio
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gstreamer
  ];

  preConfigure = ''
    mkdir -p mkspecs/modules
    ln -sf "$(qmake -query QMAKE_MKSPECS)/modules"/*.pri mkspecs/modules/ 2>/dev/null || true

    for pkg in \
      ${kdePackages.qtbase} ${kdePackages.qtbase.dev} \
      ${kdePackages.qtsvg} ${kdePackages.qtsvg.dev} \
      ${kdePackages.qtwayland} ${kdePackages.qtwayland.dev}; do
      if [ -d "$pkg" ]; then
        find "$pkg" -name "qt_*.pri" -exec ln -sf {} mkspecs/modules/ \;
      fi
    done

    export QMAKEMODULES="$PWD/mkspecs/modules"
    qmakeFlags+=("QMAKEMODULES=$PWD/mkspecs/modules")
  '';

  qmakeFlags = [
    "-r"
  ]
  ++ lib.optionals usePulseaudio [
    "CONFIG+=USE_PULSEAUDIO"
  ];

  preFixup = lib.optionalString usePulseaudio ''
    qtWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  # https://github.com/Audio4Linux/JDSP4Linux/issues/228
  env.NIX_CFLAGS_COMPILE = toString [
    "-Wno-error=incompatible-pointer-types"
    "-Wno-error=implicit-int"
    "-Wno-error=implicit-function-declaration"
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "jamesdsp";
      desktopName = "JamesDSP";
      genericName = "Audio effects processor";
      exec = "jamesdsp";
      icon = "jamesdsp";
      comment = "JamesDSP for Linux";
      categories = [
        "AudioVideo"
        "Audio"
      ];
      startupNotify = false;
      keywords = [
        "equalizer"
        "audio"
        "effect"
      ];
    })
  ];

  postInstall = ''
    install -D resources/icons/icon.png $out/share/icons/hicolor/512x512/apps/jamesdsp.png
    install -D resources/icons/icon.svg $out/share/icons/hicolor/scalable/apps/jamesdsp.svg
  '';

  meta = {
    broken = (stdenv.hostPlatform.isLinux && stdenv.hostPlatform.isAarch64);
    description = "Audio effect processor for PipeWire clients";
    mainProgram = "jamesdsp";
    homepage = "https://github.com/Audio4Linux/JDSP4Linux";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pasqui23
      wineee
    ];
    platforms = lib.platforms.linux;
  };
})
