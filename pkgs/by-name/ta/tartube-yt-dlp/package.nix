{
  tartube,
  yt-dlp,
  ...
}@args:

tartube.override (
  {
    youtube-dl = yt-dlp;
  }
  // removeAttrs args [
    "tartube"
    "yt-dlp"
  ]
)
