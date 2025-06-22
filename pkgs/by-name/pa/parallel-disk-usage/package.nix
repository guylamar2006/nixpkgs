{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "parallel-disk-usage";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "KSXGitHub";
    repo = "parallel-disk-usage";
    rev = version;
    hash = "sha256-0SK7v5xKMPuukyYKaGk13PE3WygHginjnyoatkA5xFQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-mmR5avrzqkOvitLrc3XP+1Z7TbLeSGifDP7c3MwghO4=";

  meta = {
    description = "Highly parallelized, blazing fast directory tree analyzer";
    homepage = "https://github.com/KSXGitHub/parallel-disk-usage";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ peret ];
    mainProgram = "pdu";
  };
}
