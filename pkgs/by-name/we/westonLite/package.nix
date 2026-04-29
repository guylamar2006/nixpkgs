{
  weston,
  ...
}@args:

weston.override (
  {
    demoSupport = false;
    jpegSupport = false;
    lcmsSupport = false;
    luaSupport = false;
    pangoSupport = false;
    pipewireSupport = false;
    rdpSupport = false;
    remotingSupport = false;
    vaapiSupport = false;
    vncSupport = false;
    vulkanSupport = false;
    webpSupport = false;
    xwaylandSupport = false;
  }
  // removeAttrs args [ "weston" ]
)
