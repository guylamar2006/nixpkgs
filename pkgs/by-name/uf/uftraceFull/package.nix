{
  uftrace,
  ...
}@args:

uftrace.override (
  {
    withLuaJIT = true;
    withPython = true;
  }
  // removeAttrs args [ "uftrace" ]
)
