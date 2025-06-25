{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "kubedb-cli";
  version = "0.55.0";

  src = fetchFromGitHub {
    owner = "kubedb";
    repo = "cli";
    tag = "v${version}";
    hash = "sha256-bjmsbka81krxqlV9PTMgGrJ8LN6Qr+SXZF0elttaFqI=";
  };

  vendorHash = null;

  # Don't compile the documentation stuff
  subPackages = [ "cmd/kubectl-dba" ];

  meta = {
    description = "kubectl plugin for KubeDB by AppsCode";
    homepage = "https://github.com/kubedb/cli";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ starcraft66 ];
  };
}
