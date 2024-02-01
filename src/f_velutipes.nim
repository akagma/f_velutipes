import std/options

import boxy
import bumpy
import windy

import f_velutipes/types
import f_velutipes/widgets
import f_velutipes/window_manager


export boxy
export windy

export types
export widgets
export window_manager


func getTranslateX(
  horizontalAlignment: HorizontalAlignment,
  padding: Padding
): float32 =
  case horizontalAlignment:
  of LeftAlign:
    padding.left
  of CenterAlign:
    0
  of RightAlign:
    -padding.right


func getTranslateY(
  verticalAlignment: VerticalAlignment,
  padding: Padding
): float32 =
  case verticalAlignment:
  of TopAlign:
    padding.top
  of MiddleAlign:
    0
  of BottomAlign:
    -padding.bottom


func getTranslate(
  horizontalAlignment: HorizontalAlignment,
  verticalAlignment: VerticalAlignment,
  padding: Padding
): Vec2 =
  vec2(
    getTranslateX(horizontalAlignment, padding),
    getTranslateY(verticalAlignment, padding)
  )


proc addImage(bxy: Boxy, label: Label) =
  let textImage = newImage(label.shape.w.int, label.shape.h.int)
  textImage.fillText(
    label.font.typeset(
      label.text,
      vec2(label.shape.w, label.shape.h),
      label.horizontalAlignment,
      label.verticalAlignment
    ),
    translate(
      getTranslate(
        label.horizontalAlignment,
        label.verticalAlignment,
        label.padding
      )
    )
  )

  bxy.addImage(label.name, textImage)

  if label.tooltip.isSome():
    let
      tooltip = label.tooltip.get()
      tooltipImage =
        newImage(
          tooltip.size.x.int,
          tooltip.size.y.int
        )

    tooltipImage.fillText(
      tooltip.font.typeset(
        tooltip.text,
        tooltip.size,
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment
      ),
      translate(getTranslate(
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment,
        tooltip.padding
      ))
    )
    bxy.addImage(label.name & "_tooltip", tooltipImage)


proc addImage(bxy: Boxy, lineEdit: LineEdit) =
  let textImage = newImage(lineEdit.shape.w.int, lineEdit.shape.h.int)
  textImage.fillText(
    lineEdit.font.typeset(
      lineEdit.text,
      vec2(lineEdit.shape.w, lineEdit.shape.h),
      lineEdit.horizontalAlignment,
      lineEdit.verticalAlignment
    ),
    translate(
      getTranslate(
        lineEdit.horizontalAlignment,
        lineEdit.verticalAlignment,
        lineEdit.padding
      )
    )
  )

  bxy.addImage(lineEdit.name, textImage)

  if lineEdit.tooltip.isSome():
    let
      tooltip = lineEdit.tooltip.get()
      tooltipImage =
        newImage(
          tooltip.size.x.int,
          tooltip.size.y.int
        )

    tooltipImage.fillText(
      tooltip.font.typeset(
        tooltip.text,
        tooltip.size,
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment
      ),
      translate(getTranslate(
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment,
        tooltip.padding
      ))
    )
    bxy.addImage(lineEdit.name & "_tooltip", tooltipImage)


proc addImage(bxy: Boxy, button: RadioButton) =
  let
    bgShapeImage =
      newImage(button.boundaryBox.h.int, button.boundaryBox.h.int)
    bgCtx = newContext(bgShapeImage)

  if button.bgcolor.isSome():
    bgCtx.beginPath()

    bgCtx.fillStyle.color = parseHtmlColor("#ffffff")

    bgCtx.fillCircle(
      circle(
        vec2(button.bgshape.radius, button.bgshape.radius),
        button.bgshape.radius
      )
    )
    bgCtx.closePath()
    bxy.addImage(button.name & "_bg_shape", bgShapeImage)

  let
    fgShapeImage =
      newImage(
        button.boundaryBox.h.int,
        button.boundaryBox.h.int
      )
    fgCtx = newContext(fgShapeImage)

  if button.fgcolor.isSome():
    fgCtx.beginPath()

    fgCtx.fillStyle.color = parseHtmlColor("#ffffff")

    fgCtx.fillCircle(
      circle(
        vec2(button.bgshape.radius, button.bgshape.radius),
        button.fgshape.radius
      )
    )
    fgCtx.closePath()
    bxy.addImage(button.name & "_fg_shape", fgShapeImage)

  let
    textWidth = button.boundaryBox.w
    textHeight = button.boundaryBox.h
    textImage = newImage(textWidth.int, textHeight.int)

  textImage.fillText(
    button.font.typeset(
      button.text,
      vec2(textwidth, textheight),
      HorizontalAlignment.LeftAlign,
      Verticalalignment.MiddleAlign
    ),
    translate(
      vec2(
        button.bgshape.radius * 2 + button.gap,
        0
      )
    )
  )
  bxy.addImage(button.name & "_text", textImage)

  if button.tooltip.isSome():
    let
      tooltip = button.tooltip.get()
      tooltipImage =
        newImage(
          tooltip.size.x.int,
          tooltip.size.y.int
        )

    tooltipImage.fillText(
      tooltip.font.typeset(
        tooltip.text,
        tooltip.size,
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment
      ),
      translate(
        getTranslate(
          tooltip.horizontalAlignment,
          tooltip.verticalAlignment,
          tooltip.padding
        )
      )
    )
    bxy.addImage(button.name & "_tooltip", tooltipImage)


proc addImage(bxy: Boxy, button: PushButton) =
  case button.shape.kind
  of pbskCircle:
    let
      shapeImage = newImage(button.boundaryBox.w.int, button.boundaryBox.h.int)
      ctx = newContext(shapeImage)

    if button.bgcolor.isSome():
      ctx.fillStyle.color = parseHtmlColor("#ffffff")

      ctx.beginPath()
      ctx.fillCircle(circle(
        vec2(button.shape.circle.radius, button.shape.circle.radius),
        button.shape.circle.radius
      ))
      ctx.closePath()
      bxy.addImage(button.name, shapeImage)

  of pbskRect:
    if button.cornerRadius.isSome():
      let cornerRadius = button.cornerRadius.get()

      if button.bgcolor.isSome():
        let
          shapeImage = newImage(button.boundaryBox.w.int, button.boundaryBox.h.int)
          ctx = newContext(shapeImage)
        
        ctx.fillStyle.color =
          parseHtmlColor("#ffffff")
        
        ctx.beginPath()
        ctx.fillRoundedRect(
          rect(0, 0, button.boundaryBox.w, button.boundaryBox.h),
          cornerRadius.leftTop,
          cornerRadius.rightTop,
          cornerRadius.rightBottom,
          cornerRadius.leftBottom
        )
        ctx.closePath()
        bxy.addImage(button.name, shapeImage)

  let textImage = newImage(button.boundaryBox.w.int, button.boundaryBox.h.int)
  textImage.fillText(
    button.font.typeset(
      button.text,
      vec2(button.boundaryBox.w, button.boundaryBox.h),
      CenterAlign,
      MiddleAlign
    ),
    translate(vec2(0, 0))
  )

  bxy.addImage(button.name & "_text", textImage)

  if button.tooltip.isSome():
    let
      tooltip = button.tooltip.get()
      tooltipImage = newImage(
        tooltip.size.x.int,
        tooltip.size.y.int
      )

    tooltipImage.fillText(
      tooltip.font.typeset(
        tooltip.text,
        tooltip.size,
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment
      ),
      translate(getTranslate(
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment,
        tooltip.padding
      ))
    )
    bxy.addImage(button.name & "_tooltip", tooltipImage)


proc addImage(bxy: Boxy, button: CheckButton) =
  let
    bgShapeImage =
      newImage(button.bgshape.w.int, button.bgshape.h.int)
    bgCtx = newContext(bgShapeImage)

  if button.bgcolor.isSome():
    bgCtx.beginPath()

    bgCtx.fillStyle.color = parseHtmlColor("#ffffff")

    bgCtx.fillRect(
      rect(
        0,
        0,
        button.bgshape.w,
        button.bgshape.h
      )
    )
    bgCtx.closePath()
    bxy.addImage(button.name & "_bg_shape", bgShapeImage)

  let
    fgShapeImage =
      newImage(
        button.bgshape.w.int,
        button.bgshape.h.int
      )
    fgCtx = newContext(fgShapeImage)

  if button.fgcolor.isSome():
    fgCtx.beginPath()

    fgCtx.fillStyle.color = parseHtmlColor("#ffffff")

    fgCtx.fillRect(
      rect(
        (button.bgshape.w - button.fgshape.w) / 2,
        (button.bgshape.h - button.fgshape.h) / 2,
        button.fgshape.w,
        button.fgshape.h
      )
    )
    fgCtx.closePath()
    bxy.addImage(button.name & "_fg_shape", fgShapeImage)

  let
    textWidth = button.boundaryBox.w
    textHeight = button.boundaryBox.h
    textImage = newImage(textWidth.int, textHeight.int)

  textImage.fillText(
    button.font.typeset(
      button.text,
      vec2(textwidth, textheight),
      HorizontalAlignment.LeftAlign,
      Verticalalignment.MiddleAlign
    ),
    translate(
      vec2(
        button.bgshape.w + button.gap,
        0
      )
    )
  )
  bxy.addImage(button.name & "_text", textImage)

  if button.tooltip.isSome():
    let
      tooltip = button.tooltip.get()
      tooltipImage =
        newImage(
          tooltip.size.x.int,
          tooltip.size.y.int
        )

    tooltipImage.fillText(
      tooltip.font.typeset(
        tooltip.text,
        tooltip.size,
        tooltip.horizontalAlignment,
        tooltip.verticalAlignment
      ),
      translate(
        getTranslate(
          tooltip.horizontalAlignment,
          tooltip.verticalAlignment,
          tooltip.padding
        )
      )
    )
    bxy.addImage(button.name & "_tooltip", tooltipImage)


proc addImage(bxy: Boxy, layout: Layout) =
  let children = layout.children
  for child in children:
    case child.kind
    of wkLayout:
      bxy.addImage(child.layout)
    of wkLabel:
      bxy.addImage(child.label)
    of wkLineEdit:
      bxy.addImage(child.lineEdit)
    of wkRadioButton:
      bxy.addImage(child.radioButton)
    of wkPushButton:
      bxy.addImage(child.pushButton)
    of wkCheckButton:
      bxy.addImage(child.checkButton)
    of wkSlider:
      discard


proc addImage(bxy: Boxy, widget: FlammulinaVelutipesWidget) =
  case widget.kind
  of wkLayout:
    bxy.addImage(widget.layout)
  of wkLabel:
    bxy.addImage(widget.label)
  of wkLineEdit:
    bxy.addImage(widget.lineEdit)
  of wkRadioButton:
    bxy.addImage(widget.radioButton)
  of wkPushButton:
    bxy.addImage(widget.pushButton)
  of wkCheckButton:
    bxy.addImage(widget.checkButton)
  of wkSlider:
    discard


proc addImage*(self: WindowManager) =
  self.boxy.addImage(self.rootWidget)


proc updateImage(bxy: Boxy, lineEdit: LineEdit) =
  bxy.removeImage(lineEdit.name)

  let textImage = newImage(lineEdit.shape.w.int, lineEdit.shape.h.int)
  textImage.fillText(
    lineEdit.font.typeset(
      lineEdit.text,
      vec2(lineEdit.shape.w, lineEdit.shape.h),
      lineEdit.horizontalAlignment,
      lineEdit.verticalAlignment
    ),
    translate(
      getTranslate(
        lineEdit.horizontalAlignment,
        lineEdit.verticalAlignment,
        lineEdit.padding
      )
    )
  )

  bxy.addImage(lineEdit.name, textImage)


proc updateImage(bxy: Boxy, widget: FlammulinaVelutipesWidget) =
  if widget.updated():
    case widget.kind:
    of wkLineEdit:
      bxy.updateImage(widget.lineEdit)
      widget.lineEdit.updated = false
    else:
      discard
  
  case widget.kind:
  of wkLayout:
    for child in widget.layout.children:
      updateImage(bxy, child)
  else:
    discard


proc updateImage*(self: WindowManager) =
  self.boxy.updateImage(self.rootWidget)


proc draw(bxy: Boxy, label: Label, parentEnabled: bool) =
  if not label.visible:
    return

  let enabled = parentEnabled and label.enabled
  if label.bgcolor.isSome():
    let
      bgcolor = label.bgcolor.get()
      color = 
        if enabled:
          if label.hovered:
            bgcolor.hover
          else:
            bgcolor.enabled
        else: bgcolor.disabled
    bxy.drawRect(label.shape, color)

  bxy.drawImage(label.name, vec2(label.boundaryBox.x, label.boundaryBox.y))


proc draw(bxy: Boxy, lineEdit: LineEdit, parentEnabled: bool) =
  if not lineEdit.visible:
    return

  let enabled = parentEnabled and lineEdit.enabled
  if lineEdit.bgcolor.isSome():
    let
      bgcolor = lineEdit.bgcolor.get()
      color = 
        if enabled:
          if lineEdit.hovered:
            bgcolor.hover
          else:
            bgcolor.enabled
        else: bgcolor.disabled
    bxy.drawRect(lineEdit.shape, color)
  
  if lineEdit.focused:
    if lineEdit.cursorVisible:
      bxy.drawRect(lineEdit.cursor.shape, lineEdit.cursor.color)

    lineEdit.cursorWait += 1
    if lineEdit.cursorWait == lineEdit.cursorWaitMax:
      lineEdit.cursorWait = 0
      lineEdit.cursorVisible = not lineEdit.cursorVisible


  bxy.drawImage(lineEdit.name, vec2(lineEdit.boundaryBox.x, lineEdit.boundaryBox.y))


proc draw(bxy: Boxy, button: RadioButton, parentEnabled: bool) =
  if not button.visible:
    return

  let enabled = parentEnabled and button.enabled
  if button.bgcolor.isSome():
    let
      bgcolor = button.bgcolor.get()
      color = 
        if enabled:
          if button.hovered:
            bgcolor.hover
          else:
            bgcolor.enabled
        else: bgcolor.disabled

    bxy.drawImage(
      button.name & "_bg_shape",
      vec2(button.boundaryBox.x, button.boundaryBox.y),
      color
    )

  if button.checked:
    if button.fgcolor.isSome():
      let
        fgcolor = button.fgcolor.get()
        color = 
          if enabled:
            if button.hovered:
              fgcolor.hover
            else:
              fgcolor.enabled
          else: fgcolor.disabled

      bxy.drawImage(
        button.name & "_fg_shape",
        vec2(button.boundaryBox.x, button.boundaryBox.y),
        color
      )

  bxy.drawImage(
    button.name & "_text",
    vec2(button.boundaryBox.x, button.boundaryBox.y)
  )


proc draw(bxy: Boxy, button: PushButton, parentEnabled: bool) =
  if not button.visible:
    return

  let
    enabled = parentEnabled and button.enabled
 
    y =
      if not button.pushed:
        button.boundaryBox.y
      else:
        button.boundaryBox.y + 2
   
  if button.pushed:
    button.pushWait += 1
    if button.pushWait == button.pushWaitMax:
      button.pushWait = 0
      button.pushed = false

  case button.shape.kind
  of pbskCircle:
    if button.bgcolor.isSome():
      let
        bgcolor = button.bgcolor.get()
        color =
          if enabled:
            if button.hovered:
              bgcolor.hover
            else:
              bgcolor.enabled
          else:
            bgcolor.disabled

      bxy.drawImage(
        button.name,
        vec2(button.boundaryBox.x, y),
        color
      )

  of pbskRect:
    if button.bgcolor.isSome():
      let
        bgcolor = button.bgcolor.get()
        color = 
          if enabled:
            if button.hovered:
              bgcolor.hover
            else:
              bgcolor.enabled
          else: bgcolor.disabled
    
      if button.cornerRadius.isSome():
        bxy.drawImage(button.name, vec2(button.boundaryBox.x, y), color)
      else:
        bxy.drawRect(
          rect(
            button.shape.rect.x,
            y,
            button.shape.rect.w,
            button.shape.rect.h
          ),
          color
        )

  let pos = vec2(button.boundaryBox.x, y)
  bxy.drawImage(button.name & "_text", pos)


proc draw(bxy: Boxy, button: CheckButton, parentEnabled: bool) =
  if not button.visible:
    return

  let enabled = parentEnabled and button.enabled
  if button.bgcolor.isSome():
    let
      bgcolor = button.bgcolor.get()
      color = 
        if enabled:
          if button.hovered:
            bgcolor.hover
          else:
            bgcolor.enabled
        else: bgcolor.disabled

    bxy.drawImage(
      button.name & "_bg_shape",
      vec2(button.boundaryBox.x, button.boundaryBox.y),
      color
    )

  if button.checked:
    if button.fgcolor.isSome():
      let
        fgcolor = button.fgcolor.get()
        color = 
          if enabled:
            if button.hovered:
              fgcolor.hover
            else:
              fgcolor.enabled
          else: fgcolor.disabled

      bxy.drawImage(
        button.name & "_fg_shape",
        vec2(button.boundaryBox.x, button.boundaryBox.y),
        color
      )

  bxy.drawImage(
    button.name & "_text",
    vec2(button.boundaryBox.x, button.boundaryBox.y)
  )
 

proc draw(bxy: Boxy, slider: Slider, parentEnabled: bool) =
  if not slider.visible:
    return

  let enabled = parentEnabled and slider.enabled
  if slider.bgcolor.isSome():
    let
      bgcolor = slider.bgcolor.get()
      color = 
        if enabled:
          if slider.hovered:
            bgcolor.hover
          else:
            bgcolor.enabled
        else: bgcolor.disabled
    
    bxy.drawRect(slider.bgshape, color)

  if slider.fgcolor.isSome():
    let
      fgcolor = slider.fgcolor.get()
      color = 
        if enabled:
          if slider.hovered:
            fgcolor.hover
          else:
            fgcolor.enabled
        else: fgcolor.disabled

    let
      offsetx =
        slider.value /
        (slider.valueRange[1] - slider.valueRange[0]) *
        slider.bgshape.w

    bxy.drawRect(
      rect(
        slider.fgshape.x + offsetx,
        slider.fgshape.y,
        slider.fgshape.w,
        slider.fgshape.h,
      ),
      color
    )


proc draw(bxy: Boxy, widget: FlammulinaVelutipesWidget, parentEnabled = true) {.cdecl.}


proc draw(bxy: Boxy, layout: Layout, parentEnabled: bool) =
  if not layout.visible:
    return

  let enabled = parentEnabled and layout.enabled

  if layout.bgcolor.isSome():
    let
      bgcolor = layout.bgcolor.get()
      color = 
        if enabled: bgcolor.enabled
        else: bgcolor.disabled
    bxy.drawRect(layout.boundaryBox, color)

  let children = layout.children
  for child in children:
    bxy.draw(child, enabled)


proc draw(bxy: Boxy, widget: FlammulinaVelutipesWidget, parentEnabled = true) =
  case widget.kind
  of wkLayout:
    bxy.draw(widget.layout, parentEnabled)
  of wkLabel:
    bxy.draw(widget.label, parentEnabled)
  of wkLineEdit:
    bxy.draw(widget.lineEdit, parentEnabled)
  of wkRadioButton:
    bxy.draw(widget.radioButton, parentEnabled)
  of wkPushButton:
    bxy.draw(widget.pushButton, parentEnabled)
  of wkCheckButton:
    bxy.draw(widget.checkButton, parentEnabled)
  of wkSlider:
    bxy.draw(widget.slider, parentEnabled)


proc drawToolTip(
  bxy: Boxy,
  tooltip: Tooltip,
  name: string,
  mousePos: IVec2,
  maxSize: IVec2
) =
  let
    maxPosition =
      mousePos +
      (vec2(tooltip.margin.left, tooltip.margin.top) + tooltip.size).ivec2
    x =
      if maxPosition.x > maxSize.x:
        mousePos.x.float32 - (tooltip.size.x + tooltip.margin.right)
      else:
        mousePos.x.float32 + tooltip.margin.left
    y =
      if maxPosition.y > maxSize.y:
        mousePos.y.float32 - (tooltip.size.y + tooltip.margin.bottom)
      else:
        mousePos.y.float32 + tooltip.margin.top

  bxy.drawRect(
    rect(
      x = x,
      y = y,
      w = tooltip.size.x,
      h = tooltip.size.y
    ),
    tooltip.color
  )
  bxy.drawImage(name, vec2(x, y))


proc drawToolTip(
  bxy: Boxy,
  label: Label,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if
    parentEnabled and
    label.visible and
    label.enabled and
    label.hovered and
    label.tooltip.isSome():

    let tooltip = label.tooltip.get()
    bxy.drawToolTip(tooltip, label.name & "_tooltip", mousePos, maxSize)


proc drawToolTip(
  bxy: Boxy,
  lineEdit: LineEdit,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if
    parentEnabled and
    lineEdit.visible and
    lineEdit.enabled and
    lineEdit.hovered and
    lineEdit.tooltip.isSome():

    let tooltip = lineEdit.tooltip.get()
    bxy.drawToolTip(tooltip, lineEdit.name & "_tooltip", mousePos, maxSize)


proc drawToolTip(
  bxy: Boxy,
  button: RadioButton,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if 
    parentEnabled and
    button.visible and
    button.enabled and
    button.hovered and
    button.tooltip.isSome():

    let tooltip = button.tooltip.get()
    bxy.drawToolTip(tooltip, button.name & "_tooltip", mousePos, maxSize)


proc drawToolTip(
  bxy: Boxy,
  button: PushButton,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if 
    parentEnabled and
    button.visible and
    button.enabled and
    button.hovered and
    button.tooltip.isSome():

    let tooltip = button.tooltip.get()
    bxy.drawToolTip(tooltip, button.name & "_tooltip", mousePos, maxSize)


proc drawToolTip(
  bxy: Boxy,
  button: CheckButton,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if 
    parentEnabled and
    button.visible and
    button.enabled and
    button.hovered and
    button.tooltip.isSome():

    let tooltip = button.tooltip.get()
    bxy.drawToolTip(tooltip, button.name & "_tooltip", mousePos, maxSize)


proc drawToolTip(
  bxy: Boxy,
  layout: Layout,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  if not layout.visible:
    return

  let enabled = parentEnabled and layout.enabled
  if not enabled:
    return

  # if not layout.hovered:
  #   return

  let children = layout.children
  for child in children:
    case child.kind
    of wkLayout:
      bxy.drawToolTip(child.layout, mousePos, maxSize, enabled)
    of wkLabel:
      bxy.drawToolTip(child.label, mousePos, maxSize, enabled)
    of wkLineEdit:
      bxy.drawToolTip(child.lineEdit, mousePos, maxSize, enabled)
    of wkRadioButton:
      bxy.drawToolTip(child.radioButton, mousePos, maxSize, enabled)
    of wkPushButton:
      bxy.drawToolTip(child.pushButton, mousePos, maxSize, enabled)
    of wkCheckButton:
      bxy.drawToolTip(child.checkButton, mousePos, maxSize, enabled)
    of wkSlider:
      discard


proc drawToolTip(
  bxy: Boxy,
  widget: FlammulinaVelutipesWidget,
  mousePos: IVec2,
  maxSize: IVec2,
  parentEnabled = true
) =
  case widget.kind
  of wkLayout:
    bxy.drawToolTip(widget.layout, mousePos, maxSize, parentEnabled)
  of wkLabel:
    bxy.drawToolTip(widget.label, mousePos, maxSize, parentEnabled)
  of wkLineEdit:
    bxy.drawToolTip(widget.lineEdit, mousePos, maxSize, parentEnabled)
  of wkRadioButton:
    bxy.drawToolTip(widget.radioButton, mousePos, maxSize, parentEnabled)
  of wkPushButton:
    bxy.drawToolTip(widget.pushButton, mousePos, maxSize, parentEnabled)
  of wkCheckButton:
    bxy.drawToolTip(widget.checkButton, mousePos, maxSize, parentEnabled)
  of wkSlider:
    discard


# Called when it is time to draw a new frame.
proc display(
  window: Window,
  bxy: Boxy,
  rootWidget: FlammulinaVelutipesWidget,
  frame: int
) =
  let mousePos = window.mousePos()

  # Clear the screen and begin a new frame.
  bxy.beginFrame(window.size)

  # Draw the rings.
  # let center = windowSize.vec2 / 2
  # bxy.drawImage("ring1", center, angle = frame.float / 100)
  # bxy.drawImage("ring2", center, angle = -frame.float / 190)
  # bxy.drawImage("ring3", center, angle = frame.float / 170)

  bxy.draw(rootWidget)
  bxy.drawToolTip(rootWidget, mousePos, window.size)

  # End this frame, flushing the draw commands.
  bxy.endFrame()

  # Swap buffers displaying the new Boxy frame.
  window.swapBuffers()


proc display*(self: WindowManager, frame: int) =
  display(self.window, self.boxy, self.rootWidget, frame)


proc main(): cint =
  # Load the images.
  # bxy.addImage("bg", readImage("examples/data/bg.png"))
  # bxy.addImage("ring1", readImage("examples/data/ring1.png"))
  # bxy.addImage("ring2", readImage("examples/data/ring2.png"))
  # bxy.addImage("ring3", readImage("examples/data/ring3.png"))

  const
    labelBackgroundColor =
      WidgetColor(
        enabled: parseHtmlColor("#fd0000"),
        disabled: parseHtmlColor("#666666"),
        hover: parseHtmlColor("#ff6666")
      )

  var
    testLabelLeft =
      label(
        name = "label_test_left",
        text = "test label left",
        bgcolor = some(labelBackgroundColor),
        tooltip = some(tooltip(text = "test tooltip\nthis is a description"))
      )
    testButtonLeft =
      rectPushButton(
        name = "button_test_left",
        text = "test left",
        tooltip =
          some(
            tooltip(
              text =
                "this button can control visibility\nof the label_test_left_bottom"
            )
          )
      )
    testLabelLeftBottom = label(
      name = "label_test_left_bottom",
      text = "test label left bottom\nhoge fuga piyo\nhoge fuga piyo",
      bgcolor = some(labelBackgroundColor)
    )
    verticalLayoutLeft = layout(
      name = "vertical_layout_left",
      direction = LayoutDirection.Vertical,
      verticalSizeState = WidgetSizeState.Minimum,
      bgcolor = some(WidgetColor(
        enabled: parseHtmlColor("#005d00"),
        disabled: parseHtmlColor("#444444"),
        hover: parseHtmlColor("#005d00"),
      )),
      children = @[
        testLabelLeft,
        testButtonLeft,
        testLabelLeftBottom
      ]
    )

    testLabelCenter = label(
      name = "label_test_center",
      text = "test label center",
      bgcolor = some(labelBackgroundColor)
    )
    testButtonCenter = rectPushButton(
      name = "button_test_center",
      text = "test center disabled",
      enabled = false,
      onClicked = proc() = echo "hello button_test_center disabled!"
    )
    verticalLayoutCenter = layout(
      name = "vertical_layout_center",
      direction = LayoutDirection.Vertical,
      children = @[
        testLabelCenter,
        testButtonCenter
      ],
      horizontalAlignment = LayoutHorizontalAlignment.Center,
      bgcolor = some(WidgetColor(
        enabled: parseHtmlColor("#005d00"),
        disabled: parseHtmlColor("#444444"),
        hover: parseHtmlColor("#005d00"),
      ))
    )

    horizontalLayoutTop = layout(
      name = "horizontal_layout",
      direction = LayoutDirection.Horizontal,
      verticalAlignment = LayoutVerticalAlignment.Center,
      bgcolor = some(WidgetColor(
        enabled: parseHtmlColor("#005fd0"),
        disabled: parseHtmlColor("#005fd0"),
        hover: parseHtmlColor("#005fd0")
      )),
      children = @[
        verticalLayoutLeft,
        verticalLayoutCenter,
        layout(
          name = "vertical_layout_right",
          direction = LayoutDirection.Vertical,
          children = @[
            label(
              name = "label_test_right_disabled",
              text = "test label right disabled",
              bgcolor = some(labelBackgroundColor),
              enabled = false
            ),
            rectPushButton(
              name = "button_test_right",
              text = "test right",
              onClicked = proc() =
                echo "button_test_right clicked!"
            ),
            label(
              name = "label_test_right_expand",
              text = "test label right expand",
              bgcolor = some(labelBackgroundColor)
            ),
          ],
          horizontalAlignment = LayoutHorizontalAlignment.Right,
          bgcolor = some(WidgetColor(
            enabled: parseHtmlColor("#005d00"),
            disabled: parseHtmlColor("#444444"),
            hover: parseHtmlColor("#005d00")
          )),
          enabled = false
        ),
        label(
          name = "label_test_right_middle",
          text = "test label right middle very long long label text",
          bgcolor = some(labelBackgroundColor),
          horizontalAlignment = HorizontalAlignment.RightAlign
        )
      ]
    )

    hogeLabel =
      label(
        name = "label_hoge",
        text = "hoge",
        bgcolor = some(labelBackgroundColor)
      )
    fugaLabel =
      label(
        name = "label_fuga",
        text = "fuga",
        bgcolor = some(labelBackgroundColor)
      )
    piyoButton =
      rectPushButton(
        name = "button_piyo",
        text = "piyo"
      )
    hogehogeButton =
      rectPushButton(
        name = "button_hogehoge",
        text = "hide",
        tooltip = some(tooltip(text = "change label hoge visibility"))
      )
    horizontalLayout =
      layout(
        name = "horizontal_layout",
        direction = LayoutDirection.Horizontal,
        horizontalSizeState = WidgetSizeState.Minimum,
        verticalAlignment = LayoutVerticalAlignment.Bottom,
        bgcolor =
          some(
            WidgetColor(
              enabled: parseHtmlColor("#005fd0"),
              disabled: parseHtmlColor("#005fd0"),
              hover: parseHtmlColor("#005fd0")
            )
          ),
        children =
          @[
            hogeLabel,
            fugaLabel,
            piyoButton,
            hogehogeButton
          ]
      )

    rootLayout =
      layout(
        name = "root_layout",
        direction = LayoutDirection.Vertical,
        horizontalAlignment = LayoutHorizontalAlignment.Right,
        bgcolor =
          some(
            WidgetColor(
              enabled: parseHtmlColor("#0000fd"),
              disabled: parseHtmlColor("#fdfdfd"),
              hover: parseHtmlColor("#6666ff")
            )
          ),
        children =
          @[
            horizontalLayoutTop,
            horizontalLayout,
            layout(
              name = "vertical_layout_minimum",
              direction = LayoutDirection.Vertical,
              horizontalSizeState = WidgetSizeState.Minimum,
              horizontalAlignment = LayoutHorizontalAlignment.Center,
              bgcolor = some(WidgetColor(
                enabled: parseHtmlColor("#005fd0"),
                disabled: parseHtmlColor("#005fd0"),
                hover: parseHtmlColor("#005fd0")
              )),
              children = @[]
            ),
            layout(
              name = "vertical_layout_bottom",
              direction = LayoutDirection.Vertical,
              horizontalAlignment = LayoutHorizontalAlignment.Center,
              bgcolor =
                some(
                  WidgetColor(
                    enabled: parseHtmlColor("#005fd0"),
                    disabled: parseHtmlColor("#005fd0"),
                    hover: parseHtmlColor("#005fd0")
                  )
                ),
              children =
                @[
                  label(
                    name = "label_in_vertical_layout_bottom",
                    text = "hogehoge\nfugafuga\npiyopiyo"
                  ),
                  circlePushButton(
                    name = "button_circle_shape",
                    text = "circle",
                    tooltip =
                      some(tooltip(text = "this is a circle shape\npush button")),
                    onClicked = proc() =
                      echo "this is a circle shape push button"
                  ),
                  radioButton(
                    name = "radio_button_1",
                    text = "radio button 1",
                    checked = true,
                    tooltip = some(tooltip(text = "radio button 1"))
                  ),
                  radioButton(
                    name = "radio_button_2",
                    text = "radio button 2",
                    tooltip = some(tooltip(text = "radio button 2"))
                  ),
                  radioButton(
                    name = "radio_button_3",
                    text = "radio button 3",
                    tooltip = some(tooltip(text = "radio button 3"))
                  ),
                  checkButton(
                    name = "check_button",
                    text = "check button",
                    tooltip = some(tooltip(text = "check button"))
                  ),
                  lineEdit(
                    name = "line_edit_test",
                    text = "text"
                  ),
                  table(
                    name = "spread_sheet_test",
                    headerNames = @["ID", "Name", "Type", "Description"],
                    rows = 10
                  ),
                  slider(
                    name = "slider_test"
                  )
                ]
            )
          ]
      )

  var
    # dialogSize = ivec2(640, 480)
    frame: int

  let windowManager = newWindowManager(
    window = newWindow("Windy + Boxy", ivec2(1280, 800)),
    rootWidget = rootLayout
  )

  windowManager.addImage()

  windowManager.window.onFrame = proc() =
    windowManager.updateImage()
    windowManager.display(frame)

  testButtonLeft.pushButton.onClicked = proc() =
    testLabelLeftBottom.setVisible(not testLabelLeftBottom.visible())
    windowManager.setLayout()

  piyoButton.pushButton.onClicked = proc() =
    echo piyoButton.pushButton.name, " piyo!"

    # var buttonClose = pushButton(
    #   name = "button_dialog_ok",
    #   shape = Rect(x: 0, y: 0, w: 120, h: 40),
    #   text = "Ok"
    # )

    # let dialogWindowManager = newWindowManager(
    #   window = newWindow("Dialog", dialogSize),
    #   windowSize = dialogSize,
    #   rootWidget = layout(
    #     name = "layout_dialog_root",
    #     margin = Margin(left: 0, top: 0, right: 0, bottom: 0),
    #     bgcolor = some(WidgetColor(
    #       enabled: parseHtmlColor("#005fd0"),
    #       disabled: parseHtmlColor("#005fd0"),
    #       hover: parseHtmlColor("#005fd0")
    #     )),
    #     direction = LayoutDirection.Vertical,
    #     horizontalAlignment = LayoutHorizontalAlignment.Center,
    #     children = @[
    #       label(
    #         name = "label_dialog_message",
    #         shape = Rect(x: 0, y: 0, w: 400, h: 250),
    #         text = "This dialog is child of the main window",
    #         verticalAlignment = VerticalAlignment.TopAlign
    #       ),
    #       buttonClose
    #     ]
    #   )
    # )
    # dialogWindowManager.addImage()

    # dialogWindowManager.window.onFrame = proc() =
    #   dialogWindowManager.display(frame)

    # buttonClose.pushButton.onClicked = proc() =
    #   dialogWindowManager.window.close()

    # windowManager.addChild(dialogWindowManager)

  hogehogeButton.pushButton.onClicked = proc() =
    if hogeLabel.visible():
      hogeLabel.setVisible(false)
      hogehogeButton.pushButton.text = "showText"
    else:
      hogeLabel.setVisible(true)
      hogehogeButton.pushButton.text = "hide"

    let
      button = hogehogeButton.pushButton
      size = button.font.layoutBounds(button.text)

    hogehogeButton.pushButton.shape.rect =
      rect(
        button.boundaryBox.x,
        button.boundaryBox.y,
        size.x + button.padding.left + button.padding.right,
        size.y + button.padding.top + button.padding.bottom
      )
    if hogehogeButton.pushButton.cornerRadius.isSome():
      windowManager.boxy.removeImage(hogehogeButton.pushButton.name)
    windowManager.boxy.removeImage(hogehogeButton.pushButton.name & "_text")
    windowManager.setLayout()
    windowManager.boxy.addImage(hogehogeButton)

  while not windowManager.window.closeRequested:
    # for i in 0..<windowManager.children.len:
    #   if windowManager.children[i].window.closed():
    #     windowManager.deleteChild(i)
    #     echo "Deleted a child window manager"
    inc frame
    pollEvents()
  
  0


when isMainModule:
  quit(main())
