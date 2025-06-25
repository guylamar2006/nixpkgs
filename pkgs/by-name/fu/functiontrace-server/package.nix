{
  lib,
  rustPlatform,
  fetchCrate,
  nix-update-script,
}:

rustPlatform.buildRustPackage rec {
  pname = "functiontrace-server";
  version = "0.8.4";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-i+lXjFXCPT6Skr+r/RKYQm+iJ+WETJ/tAQg5U6qFFi8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-61+hEq0cdJZ+DTgN/ZtK6IKuwLCq3oxk0SrzqWewQXs=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Server for FunctionTrace, a graphical Python profiler";
    homepage = "https://functiontrace.com";
    license = lib.licenses.prosperity30;
    maintainers = with lib.maintainers; [ tehmatt ];
  };
}
