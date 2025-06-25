{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "librespeed-cli";
  version = "1.0.12";

  src = fetchFromGitHub {
    owner = "librespeed";
    repo = "speedtest-cli";
    tag = "v${version}";
    hash = "sha256-njaQ/Be5rDCqkZJkij0nRi8aIO5uZYo8t3BjIcdKoCM=";
  };

  vendorHash = "sha256-dmaq9+0FjqYh2ZLg8bu8cPJZ9QClcvwid1nmsftmrf0=";

  # Tests have additional requirements
  doCheck = false;

  meta = {
    description = "Command line client for LibreSpeed";
    homepage = "https://github.com/librespeed/speedtest-cli";
    changelog = "https://github.com/librespeed/speedtest-cli/releases/tag/${src.tag}";
    license = lib.licenses.lgpl3Only;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "speedtest-cli";
    broken = stdenv.hostPlatform.isDarwin;
  };
}
