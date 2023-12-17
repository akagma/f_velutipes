import std/options

import boxy
import opengl
import windy

import types
import widgets


proc addChild*(self, child: WindowManager) =
  self.children.add(child)


proc deleteChild*(self: WindowManager, index: int) =
  self.children.delete(index)


proc popChild*(self: WindowManager, index: Option[int] = none(int)): WindowManager =
  if index.isSome():
    let item = self.children[index.get()]
    self.children.delete(index.get())
    item
  else:
    self.children.pop()


proc setLayout*(self: WindowManager) =
  self.rootWidget.setLayout(self.window.size)


proc update(self: WindowManager) =
  let
    minSize = self.rootWidget.minSize()
    width = max(self.window.size.x, minSize.x.int32)
    height = max(self.window.size.y, minSize.y.int32)

  self.window.size = ivec2(width, height)
  self.setLayout()
 

proc newWindowManager*(
  window: Window,
  rootWidget: FlammulinaVelutipesWidget,
  children: seq[WindowManager] = @[],
  modal = false
): WindowManager =
  window.makeContextCurrent()
  loadExtensions()

  let windowManager = WindowManager(
    window: window,
    boxy: newBoxy(),
    rootWidget: rootWidget,
    children: children,
    modal: modal
  )
  
  windowManager.setLayout()
  windowManager.update()

  windowManager.window.onResize = proc() =
    windowManager.update()

  windowManager.window.onButtonPress = proc(button: Button) =
    # echo button
    case button
    of MouseLeft:
      # echo "Mouse left clicked"
      let mousePos = windowManager.window.mousePos
      windowManager.rootWidget.onClicked(mousePos)

    of KeyEscape:
      windowManager.window.closeRequested = true

    # alphabet
    of KeyA:
      discard windowManager.rootWidget.onKeyPress("a")
    of KeyB:
      discard windowManager.rootWidget.onKeyPress("b")
    of KeyC:
      discard windowManager.rootWidget.onKeyPress("c")
    of KeyD:
      discard windowManager.rootWidget.onKeyPress("d")
    of KeyE:
      discard windowManager.rootWidget.onKeyPress("e")
    of KeyF:
      discard windowManager.rootWidget.onKeyPress("f")
    of KeyG:
      discard windowManager.rootWidget.onKeyPress("g")
    of KeyH:
      discard windowManager.rootWidget.onKeyPress("h")
    of KeyI:
      discard windowManager.rootWidget.onKeyPress("i")
    of KeyJ:
      discard windowManager.rootWidget.onKeyPress("j")
    of KeyK:
      discard windowManager.rootWidget.onKeyPress("k")
    of KeyL:
      discard windowManager.rootWidget.onKeyPress("l")
    of KeyM:
      discard windowManager.rootWidget.onKeyPress("m")
    of KeyN:
      discard windowManager.rootWidget.onKeyPress("n")
    of KeyO:
      discard windowManager.rootWidget.onKeyPress("o")
    of KeyP:
      discard windowManager.rootWidget.onKeyPress("p")
    of KeyQ:
      discard windowManager.rootWidget.onKeyPress("q")
    of KeyR:
      discard windowManager.rootWidget.onKeyPress("r")
    of KeyS:
      discard windowManager.rootWidget.onKeyPress("s")
    of KeyT:
      discard windowManager.rootWidget.onKeyPress("t")
    of KeyU:
      discard windowManager.rootWidget.onKeyPress("u")
    of KeyV:
      discard windowManager.rootWidget.onKeyPress("v")
    of KeyW:
      discard windowManager.rootWidget.onKeyPress("w")
    of KeyX:
      discard windowManager.rootWidget.onKeyPress("x")
    of KeyY:
      discard windowManager.rootWidget.onKeyPress("y")
    of KeyZ:
      discard windowManager.rootWidget.onKeyPress("z")

    # number
    of Key0:
      discard windowManager.rootWidget.onKeyPress("0")
    of Key1:
      discard windowManager.rootWidget.onKeyPress("1")
    of Key2:
      discard windowManager.rootWidget.onKeyPress("2")
    of Key3:
      discard windowManager.rootWidget.onKeyPress("3")
    of Key4:
      discard windowManager.rootWidget.onKeyPress("4")
    of Key5:
      discard windowManager.rootWidget.onKeyPress("5")
    of Key6:
      discard windowManager.rootWidget.onKeyPress("6")
    of Key7:
      discard windowManager.rootWidget.onKeyPress("7")
    of Key8:
      discard windowManager.rootWidget.onKeyPress("8")
    of Key9:
      discard windowManager.rootWidget.onKeyPress("9")

    # symbol
    of KeySpace:
      discard windowManager.rootWidget.onKeyPress(" ")
    of KeyApostrophe:
      discard windowManager.rootWidget.onKeyPress("'")
    of KeyBacktick:
      discard windowManager.rootWidget.onKeyPress("`")
    of KeyBackslash:
      discard windowManager.rootWidget.onKeyPress("\\")
    of KeyComma:
      discard windowManager.rootWidget.onKeyPress(",")
    of KeyPeriod:
      discard windowManager.rootWidget.onKeyPress(".")
    of KeyEqual:
      discard windowManager.rootWidget.onKeyPress("=")
    of KeyMinus:
      discard windowManager.rootWidget.onKeyPress("-")
    of KeySemicolon:
      discard windowManager.rootWidget.onKeyPress(";")
    of KeyLeftBracket:
      discard windowManager.rootWidget.onKeyPress("[")
    of KeyRightBracket:
      discard windowManager.rootWidget.onKeyPress("]")

    # deletion
    of KeyBackspace:
      discard windowManager.rootWidget.onKeyBackSpacePress()
    of KeyDelete:
      discard windowManager.rootWidget.onKeyDeletePress()

    # move
    of KeyLeft:
      discard windowManager.rootWidget.onKeyLeftPress()
    # of KeyUp:
    #   windowManager.rootWidget.onKeyUpPress()
    of KeyRight:
      discard windowManager.rootWidget.onKeyRightPress()
    # of KeyDown:
    #   windowManager.rootWidget.onKeyDownPress()

    else:
      discard
  
  windowManager.window.onButtonRelease = proc(button: Button) =
    case button
    of MouseLeft:
      # echo button
      let mousePos = windowManager.window.mousePos
      discard windowManager.rootWidget.onButtonReleased(mousePos)
    else:
      discard

  windowManager.window.onMouseMove = proc() =
    let
      mousePos = windowManager.window.mousePos
    # echo "Mouse position: " & $mousePos
    discard windowManager.rootWidget.onHovered(mousePos)
    discard windowManager.rootWidget.onMouseMoved(mousePos)

  windowManager
