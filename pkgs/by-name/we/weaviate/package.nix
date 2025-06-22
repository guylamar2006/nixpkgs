{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "weaviate";
  version = "1.31.1";

  src = fetchFromGitHub {
    owner = "weaviate";
    repo = "weaviate";
    rev = "v${version}";
    hash = "sha256-df+/ZMkTpx5Z1LJ+0frUXWxyCoGPMaovC+9zfNqhDxg=";
  };

  vendorHash = "sha256-mYGWG253nH4KfrJxZpMs0Byw9YrzeNuzB28fyhbjLqg=";

  subPackages = [ "cmd/weaviate-server" ];

  ldflags = [
    "-w"
    "-extldflags"
    "-static"
  ];

  postInstall = ''
    ln -s $out/bin/weaviate-server $out/bin/weaviate
  '';

  meta = {
    description = "ML-first vector search engine";
    homepage = "https://github.com/semi-technologies/weaviate";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ dit7ya ];
  };
}
