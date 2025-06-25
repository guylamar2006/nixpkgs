{
  comma,
  fetchFromGitHub,
  fzy,
  lib,
  makeBinaryWrapper,
  nix-index-unwrapped,
  rustPlatform,
  testers,
}:

rustPlatform.buildRustPackage rec {
  pname = "comma";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "v${version}";
    hash = "sha256-XXe0SSdH2JZLx0o+vHDtdlDRtVn7nouIngipbXhmhiQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-vNXczPhCfoXHy5IT/ybuKEQ7I08eJJdP+6+iXfwWjdU=";

  nativeBuildInputs = [ makeBinaryWrapper ];

  postInstall = ''
    wrapProgram $out/bin/comma \
      --prefix PATH : ${
        lib.makeBinPath [
          fzy
          nix-index-unwrapped
        ]
      }
    ln -s $out/bin/comma $out/bin/,
  '';

  passthru.tests = {
    version = testers.testVersion { package = comma; };
  };

  meta = {
    homepage = "https://github.com/nix-community/comma";
    description = "Runs programs without installing them";
    license = lib.licenses.mit;
    mainProgram = "comma";
    maintainers = with lib.maintainers; [ artturin ];
  };
}
