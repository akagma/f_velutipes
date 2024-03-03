import std/[
  os,
  osproc,
  strformat,
]

import cligen


type ToolMode {.pure.} = enum
  DebugBuild = "debug_build"
  ReleaseBuild = "release_build"

const
  sourcePath = fmt"{getAppDir()}\\src\\f_velutipes.nim"
  destPath = fmt"{getAppDir()}\\f_velutipes.exe"

proc debugBuild(): int =
  execCmd(fmt"nim c -o:{destPath} {sourcepath}")


proc releaseBuild(): int =
  execCmd(fmt"nim c -d:release -o:{destPath} {sourcepath}")


proc main(mode: ToolMode): int =
  case mode
  of ToolMode.DebugBuild:
    debugBuild()
  of ToolMode.ReleaseBuild:
    releaseBuild()


when isMainModule:
  dispatch(main, help = {"mode": "tool mode: debug_build, release_build"})
