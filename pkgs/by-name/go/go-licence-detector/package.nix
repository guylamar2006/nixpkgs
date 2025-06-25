{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "go-licence-detector";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "elastic";
    repo = "go-licence-detector";
    rev = "v${version}";
    hash = "sha256-mytZc5sfYkzvdv53EVnM97fvfOPh+Y06j+aB8bhFv5o=";
  };

  vendorHash = "sha256-7vIP5pGFH6CbW/cJp+DiRg2jFcLFEBl8dQzUw1ogTTA=";

  meta = {
    description = "Detect licences in Go projects and generate documentation";
    homepage = "https://github.com/elastic/go-licence-detector";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ SuperSandro2000 ];
  };
}
