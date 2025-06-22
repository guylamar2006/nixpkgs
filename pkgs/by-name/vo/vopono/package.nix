{
  lib,
  fetchCrate,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "vopono";
  version = "0.10.12";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-bn3I5Yx9Kzj9ZQWn0fQUeDa6qjFAhWM38wJ/Oz3Q72k=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-vtZeL8XjsdzJcuHAVZKoI4GpcqHaOucX9qkjToIVqfQ=";

  meta = {
    description = "Run applications through VPN connections in network namespaces";
    homepage = "https://github.com/jamesmcm/vopono";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ romildo ];
    mainProgram = "vopono";
  };
}
