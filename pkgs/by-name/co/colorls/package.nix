{
  lib,
  bundlerApp,
  ruby,
  bundlerUpdateScript,
}:

bundlerApp {
  pname = "colorls";

  gemdir = ./.;
  exes = [ "colorls" ];

  passthru.updateScript = bundlerUpdateScript "colorls";

  meta = {
    description = "Prettified LS";
    homepage = "https://github.com/athityakumar/colorls";
    license = with licenses; mit;
    maintainers = with lib.maintainers; [
      lukebfox
      nicknovitski
      cbley
    ];
    platforms = ruby.meta.platforms;
    mainProgram = "colorls";
  };
}
