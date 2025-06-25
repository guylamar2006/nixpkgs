{
  lib,
  buildGoModule,
  fetchFromGitHub,
  git,
}:

buildGoModule rec {
  pname = "git-codereview";
  version = "1.15.0";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "review";
    rev = "v${version}";
    hash = "sha256-CMe7xnR/cCjphuSI0/I0zqHehkRFX6DhLFpQNKwFErU=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  nativeCheckInputs = [ git ];

  meta = {
    description = "Manage the code review process for Git changes using a Gerrit server";
    homepage = "https://golang.org/x/review/git-codereview";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ edef ];
    mainProgram = "git-codereview";
  };
}
