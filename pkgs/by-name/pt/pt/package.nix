{
  lib,
  bundlerApp,
  bundlerUpdateScript,
}:

bundlerApp {
  pname = "pt";
  gemdir = ./.;
  exes = [ "pt" ];

  passthru.updateScript = bundlerUpdateScript "pt";

  meta = with lib; {
    description = "Minimalist command-line Pivotal Tracker client";
    homepage = "http://www.github.com/raul/pt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      ebzzry
      manveru
      nicknovitski
    ];
    platforms = platforms.unix;
    mainProgram = "pt";
  };
}
