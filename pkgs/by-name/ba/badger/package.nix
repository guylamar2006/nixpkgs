{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "badger";
  version = "4.7.0";

  src = fetchFromGitHub {
    owner = "dgraph-io";
    repo = "badger";
    rev = "v${version}";
    hash = "sha256-R4nahpUuCjPas1NBnWmQ/KBTY+/yPSyo8AmTvgwhYVI=";
  };

  vendorHash = "sha256-x4+CHLmQhu7Y6n1qx2CBY6KzRIRLD7Gn+pzXQy3/5rA=";

  subPackages = [ "badger" ];

  doCheck = false;

  meta = {
    description = "Fast key-value DB in Go";
    homepage = "https://github.com/dgraph-io/badger";
    license = lib.licenses.asl20;
    mainProgram = "badger";
    maintainers = with lib.maintainers; [ farcaller ];
  };
}
