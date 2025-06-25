{ buildDotnetGlobalTool, lib }:

buildDotnetGlobalTool {
  pname = "fantomas";
  version = "7.0.2";

  nugetHash = "sha256-BAaENIm/ksTiXrUImRgKoIXTGIlgsX7ch6ayoFjhJXA=";

  meta = {
    description = "F# source code formatter";
    homepage = "https://github.com/fsprojects/fantomas";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = with lib.maintainers; [ mikaelfangel ];
    mainProgram = "fantomas";
  };
}
