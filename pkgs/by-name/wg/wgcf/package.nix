{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "wgcf";
  version = "2.2.26";

  src = fetchFromGitHub {
    owner = "ViRb3";
    repo = "wgcf";
    tag = "v${version}";
    hash = "sha256-5bVGW17zNc4sS/vwtXXWP8F4QuM+ldA00GD/z3llpCA=";
  };

  subPackages = ".";

  vendorHash = "sha256-p58RrROMzkgGPDkxsfJJX3gbuglnArgqNiqXz4Y0yF8=";

  meta = {
    description = "Cross-platform, unofficial CLI for Cloudflare Warp";
    homepage = "https://github.com/ViRb3/wgcf";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ yureien ];
    mainProgram = "wgcf";
  };
}
