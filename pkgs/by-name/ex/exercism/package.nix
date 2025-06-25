{
  lib,
  buildGoModule,
  installShellFiles,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule rec {
  pname = "exercism";
  version = "3.5.5";

  src = fetchFromGitHub {
    owner = "exercism";
    repo = "cli";
    tag = "v${version}";
    hash = "sha256-Xz+yTCFwMKd8P3PKX8e3L+XFvt0ntZrOgxnsnrFio6g=";
  };

  vendorHash = "sha256-xY3C3emqtPIKyxIN9aEkrLXhTxWNmo0EJXNZVtbtIvs=";

  doCheck = false;

  subPackages = [ "./exercism" ];

  nativeBuildInputs = [ installShellFiles ];

  passthru.updateScript = nix-update-script { };

  postInstall = ''
    installShellCompletion --cmd exercism \
      --bash shell/exercism_completion.bash \
      --fish shell/exercism.fish \
      --zsh shell/exercism_completion.zsh
  '';

  meta = {
    inherit (src.meta) homepage;
    description = "Go based command line tool for exercism.io";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      maintainers.rbasso
      maintainers.nobbz
    ];
    mainProgram = "exercism";
  };
}
