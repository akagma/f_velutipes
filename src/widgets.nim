import std/options
import std/sequtils
import std/sugar

import boxy
import bumpy

import types


const
  gofun_iro* = "#fffffc"
  nyu_haku_syoku* = "#f3f3f3"
  usu_nibi* = "#adadad"

  shikkoku* = "#0d0015"
  kuro* = "#2b2b2b"
  yokan_iro* = "#383c3c"
  nibi_iro* = "#727171"

  defaultGap = 8.0
  fgCoeff = 0.6
  defaultBackgroundColor* = 
    WidgetColor(
      enabled: parseHtmlColor(kuro),
      disabled: parseHtmlColor(nibi_iro),
      hover: parseHtmlColor(yokan_iro)
    )
  defaultForegroundColor* = 
    WidgetColor(
      enabled: parseHtmlColor(gofun_iro),
      disabled: parseHtmlColor(usu_nibi),
      hover: parseHtmlColor(nyu_haku_syoku)
    )
  defaultCornerRadius* =
    CornerRadius(leftTop: 8, rightTop: 8, leftBottom: 8, rightBottom: 8)
  defaultBorderColor* = parseHtmlColor(shikkoku)
  defaultPadding = Padding(top: 8, right: 8, bottom: 8, left: 8)
  defaultMargin = Margin(top: 8, right: 8, bottom: 8, left: 8)

  defaultLayoutPadding = Padding(top: 0, right: 0, bottom: 0, left: 0)
  defaultLayoutMargin = Margin(top: 0, right: 0, bottom: 0, left: 0)

  defaultCirclePushButtonPadding = Padding(top: 0, right: 0, bottom: 0, left: 0)
  defaultRadioButtonPadding = Padding(top: 0, right: 0, bottom: 0, left: 0)
  defaultCheckButtonPadding = Padding(top: 0, right: 0, bottom: 0, left: 0)
  defaultSliderPadding = Padding(top: 0, right: 0, bottom: 0, left: 0)

  defaultTooltipPadding = Padding(top: 8, right: 8, bottom: 8, left: 8)
  defaultTooltipMargin = Margin(top: 30, right: 0, bottom: 12, left: 12)

  defaultCursorWait = 30


var defaultFont = readFont("examples/data/Roboto-Regular_1.ttf")
defaultFont.size = 24
defaultFont.paint = parseHtmlColor(gofun_iro)


proc getMarginLeft(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.margin.left
  of wkLabel:
    self.label.margin.left
  of wkLineEdit:
    self.lineEdit.margin.left
  of wkRadioButton:
    self.radioButton.margin.left
  of wkPushButton:
    self.pushButton.margin.left
  of wkCheckButton:
    self.checkButton.margin.left
  of wkSlider:
    self.slider.margin.left


proc getMarginTop(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.margin.top
  of wkLabel:
    self.label.margin.top
  of wkLineEdit:
    self.lineEdit.margin.top
  of wkRadioButton:
    self.radioButton.margin.top
  of wkPushButton:
    self.pushButton.margin.top
  of wkCheckButton:
    self.checkButton.margin.top
  of wkSlider:
    self.slider.margin.top


proc getMarginRight(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.margin.right
  of wkLabel:
    self.label.margin.right
  of wkLineEdit:
    self.lineEdit.margin.right
  of wkRadioButton:
    self.radioButton.margin.right
  of wkPushButton:
    self.pushButton.margin.right
  of wkCheckButton:
    self.checkButton.margin.right
  of wkSlider:
    self.slider.margin.right


proc getMarginBottom(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.margin.bottom
  of wkLabel:
    self.label.margin.bottom
  of wkLineEdit:
    self.lineEdit.margin.bottom
  of wkRadioButton:
    self.radioButton.margin.bottom
  of wkPushButton:
    self.pushButton.margin.bottom
  of wkCheckButton:
    self.checkButton.margin.bottom
  of wkSlider:
    self.slider.margin.bottom


proc getMargin(self: FlammulinaVelutipesWidget): Margin =
  case self.kind
  of wkLayout:
    self.layout.margin
  of wkLabel:
    self.label.margin
  of wkLineEdit:
    self.lineEdit.margin
  of wkRadioButton:
    self.radioButton.margin
  of wkPushButton:
    self.pushButton.margin
  of wkCheckButton:
    self.checkButton.margin
  of wkSlider:
    self.slider.margin


proc getAbsoluteX(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.boundaryBox.x
  of wkLabel:
    self.label.boundaryBox.x
  of wkLineEdit:
    self.lineEdit.boundaryBox.x
  of wkRadioButton:
    self.radioButton.boundaryBox.x
  of wkPushButton:
    self.pushButton.boundaryBox.x
  of wkCheckButton:
    self.checkButton.boundaryBox.x
  of wkSlider:
    self.slider.boundaryBox.x


proc getAbsoluteY(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.boundaryBox.y
  of wkLabel:
    self.label.boundaryBox.y
  of wkLineEdit:
    self.lineEdit.boundaryBox.y
  of wkRadioButton:
    self.radioButton.boundaryBox.y
  of wkPushButton:
    self.pushButton.boundaryBox.y
  of wkCheckButton:
    self.checkButton.boundaryBox.y
  of wkSlider:
    self.slider.boundaryBox.y


proc getAbsolutePosition(self: FlammulinaVelutipesWidget): (float32, float32) =
  (self.getAbsoluteX(), self.getAbsoluteY())


proc getBoundaryBoxWidth(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.boundaryBox.w
  of wkLabel:
    self.label.boundaryBox.w
  of wkLineEdit:
    self.lineEdit.boundaryBox.w
  of wkRadioButton:
    self.radioButton.boundaryBox.w
  of wkPushButton:
    self.pushButton.boundaryBox.w
  of wkCheckButton:
    self.checkButton.boundaryBox.w
  of wkSlider:
    self.slider.boundaryBox.w


proc getBoundaryBoxHeight(self: FlammulinaVelutipesWidget): float32 =
  case self.kind
  of wkLayout:
    self.layout.boundaryBox.h
  of wkLabel:
    self.label.boundaryBox.h
  of wkLineEdit:
    self.lineEdit.boundaryBox.h
  of wkRadioButton:
    self.radioButton.boundaryBox.h
  of wkPushButton:
    self.pushButton.boundaryBox.h
  of wkCheckButton:
    self.checkButton.boundaryBox.h
  of wkSlider:
    self.slider.boundaryBox.h


proc getBoundaryBoxSize(self: FlammulinaVelutipesWidget): (float32, float32) =
  (self.getBoundaryBoxWidth(), self.getBoundaryBoxHeight())


proc getBoundaryBox(self: FlammulinaVelutipesWidget): Rect =
  case self.kind
  of wkLayout:
    self.layout.boundaryBox
  of wkLabel:
    self.label.boundaryBox
  of wkLineEdit:
    self.lineEdit.boundaryBox
  of wkRadioButton:
    self.radioButton.boundaryBox
  of wkPushButton:
    self.pushButton.boundaryBox
  of wkCheckButton:
    self.checkButton.boundaryBox
  of wkSlider:
    self.slider.boundaryBox


func getMinSize(text: string, font: Font, size: Vec2, padding: Padding): Vec2 =
  let
    bounds = font.layoutBounds(text)
    width = bounds.x + padding.left + padding.right
    height = bounds.y + padding.top + padding.bottom
  
  if size.x < width and size.y < height:
    vec2(width, height)
  elif size.x < width:
    vec2(width, size.y)
  elif size.y < height:
    vec2(size.x, height)
  else:
    size


proc tooltip*(
  text: string,
  font: Font = defaultFont,
  color: Color = parseHtmlColor(yokan_iro),
  size: Vec2 = vec2(0, 0),
  padding: Padding = defaultTooltipPadding,
  margin: Margin = defaultTooltipMargin,
  horizontalAlignment: HorizontalAlignment = LeftAlign,
  verticalAlignment: VerticalAlignment = TopAlign,
  cornerRadius = some(defaultCornerRadius)
): Tooltip =
  let minSize = getMinSize(text, font, size, padding)

  Tooltip(
    text: text,
    font: font,
    color: color,
    size: minSize,
    padding: padding,
    margin: margin,
    horizontalAlignment: horizontalAlignment,
    verticalAlignment: verticalAlignment,
    cornerRadius: cornerRadius
  )


proc layout*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultLayoutPadding,
  margin = defaultLayoutMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Expand,
  verticalSizeState = WidgetSizeState.Expand,
  movable = false,
  bgcolor = none(WidgetColor),
  border = none(Border),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),
  cornerRadius = none(CornerRadius),

  direction: LayoutDirection,
  children: seq[FlammulinaVelutipesWidget] = @[],
  horizontalAlignment = LayoutHorizontalAlignment.Left,
  verticalAlignment = LayoutVerticalAlignment.Top,
): FlammulinaVelutipesWidget =
  var widget = FlammulinaVelutipesWidget(
    kind: wkLayout,
    layout: Layout(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: minSize,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: cornerRadius,

      direction: direction,
      children: children,
      horizontalAlignment: horizontalAlignment,
      verticalAlignment: verticalAlignment
    )
  )

  var
    children = widget.layout.children
    group: seq[RadioButton] = @[]
  for i in 0..<children.len:
    case children[i].kind
    of wkLayout:
      children[i].layout.parent = some(widget)
    of wkLabel:
      children[i].label.parent = some(widget)
    of wkLineEdit:
      children[i].lineEdit.parent = some(widget)
    of wkRadioButton:
      children[i].radioButton.parent = some(widget)
      group.add(children[i].radioButton)
    of wkPushButton:
      children[i].pushButton.parent = some(widget)
    of wkCheckButton:
      children[i].checkButton.parent = some(widget)
    of wkSlider:
      children[i].slider.parent = some(widget)
  
  for i in 0..<group.len:
    group[i].group = group
  
  widget


proc label*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = none(WidgetColor),
  border = none(Border),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),
  cornerRadius = none(CornerRadius),

  text: string,
  font = defaultFont,
  horizontalAlignment = HorizontalAlignment.LeftAlign,
  verticalAlignment = VerticalAlignment.MiddleAlign
): FlammulinaVelutipesWidget =
  let size = getMinSize(text, font, minSize, padding)

  FlammulinaVelutipesWidget(
    kind: wkLabel,
    label: Label(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: size,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: cornerRadius,

      shape: rect(0, 0, size.x, size.y),
      text: text,
      font: font,
      horizontalAlignment: horizontalAlignment,
      verticalAlignment: verticalAlignment
    )
  )


proc lineEdit*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = none(Border),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),
  cornerRadius = some(defaultCornerRadius),

  shape = rect(0, 0, 300, 40),
  text: string,
  font = defaultFont,
  placeholder = none(Placeholder),
  horizontalAlignment = HorizontalAlignment.LeftAlign,
  verticalAlignment = VerticalAlignment.MiddleAlign
): FlammulinaVelutipesWidget =
  let
    size = getMinSize(text, font, minSize, padding)
    width = max(size.x, shape.w)
    height = max(size.y, shape.h)

  FlammulinaVelutipesWidget(
    kind: wkLineEdit,
    lineEdit: LineEdit(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: size,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: cornerRadius,

      shape: rect(shape.x, shape.y, width, height),
      text: text,
      font: font,
      placeholder: placeholder,
      horizontalAlignment: horizontalAlignment,
      verticalAlignment: verticalAlignment,
      currentIndex: 0,
      cursor: TextCursor(
        shape: rect(0, 0, 0.5 * font.size, font.size),
        color: parseHtmlColor(gofun_iro)
      ),
      cursorVisible: false,
      cursorWait: 0,
      cursorWaitMax: defaultCursorWait
    )
  )


proc pushButton*[T](
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),
  cornerRadius: Option[CornerRadius],

  shape: T,
  text: string,
  font = defaultFont,
  onClicked: proc() = proc() = discard
): FlammulinaVelutipesWidget =
  let size = getMinSize(text, font, minSize, padding)

  let buttonShape = 
    when T is Circle:
      PushButtonShape(kind: pbskCircle, circle: shape)
    elif T is Rect:
      PushButtonShape(kind: pbskRect, rect: shape)

  var button = FlammulinaVelutipesWidget(
    kind: wkPushButton,
    pushButton: PushButton(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: size,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: cornerRadius,

      shape: buttonShape,
      text: text,
      font: font,
      onClicked: onClicked
    )
  )

  case button.pushButton.shape.kind
  of pbskCircle:
    button.pushButton.shape.circle =
      circle(
        button.pushButton.shape.circle.pos,
        sqrt((size.x * size.x + size.y * size.y) / 2)
      )
  of pbskRect:
    button.pushButton.shape.rect =
      rect(
        button.pushButton.shape.rect.x,
        button.pushButton.shape.rect.y,
        size.x,
        size.y
      )

  button


proc circlePushButton*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultCirclePushButtonPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),

  text: string,
  font = defaultFont,
  onClicked: proc() = proc() = discard
): FlammulinaVelutipesWidget =
  pushButton(
    parent = parent,
    name = name,
    padding = padding,
    margin = margin,
    minSize = minSize,
    maxSize = maxSize,
    horizontalSizeState = horizontalSizeState,
    verticalSizeState = verticalSizeState,
    movable = movable,
    bgcolor = bgcolor,
    border = border,
    enabled = enabled,
    visible = visible,
    focused = focused,
    hovered = hovered,
    tooltip = tooltip,
    cornerRadius = none(CornerRadius),

    shape = circle(vec2(0, 0), 0),
    text = text,
    font = font,
    onClicked = onClicked
  )


proc rectPushButton*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),
  cornerRadius = some(defaultCornerRadius),

  text: string,
  font = defaultFont,
  onClicked: proc() = proc() = discard
): FlammulinaVelutipesWidget =
  pushButton(
    parent = parent,
    name = name,
    padding = padding,
    margin = margin,
    minSize = minSize,
    maxSize = maxSize,
    horizontalSizeState = horizontalSizeState,
    verticalSizeState = verticalSizeState,
    movable = movable,
    bgcolor = bgcolor,
    border = border,
    enabled = enabled,
    visible = visible,
    focused = focused,
    hovered = hovered,
    tooltip = tooltip,
    cornerRadius = cornerRadius,

    shape = rect(0, 0, 0, 0),
    text = text,
    font = font,
    onClicked = onClicked
  )


proc radioButton*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultRadioButtonPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),

  fgColor = some(defaultForegroundColor),
  text: string,
  gap = defaultGap,
  font = defaultFont,
  checked = false
): FlammulinaVelutipesWidget =
  let
    size = getMinSize(text, font, minSize, padding)
    fgradius = (size.y / 2) * fgCoeff
    bgradius = size.y / 2

  var radioButton = FlammulinaVelutipesWidget(
    kind: wkRadioButton,
    radioButton: RadioButton(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: minSize,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: none(CornerRadius),

      fgshape: circle(vec2(0, 0), fgradius),
      bgshape: circle(vec2(0, 0), bgradius),
      fgColor: fgColor,
      gap: gap,
      text: text,
      font: font,
      group: @[],
      checked: checked
    )
  )

  radioButton.radioButton.boundaryBox =
    rect(
      0,
      0,
      size.y + gap + size.x,
      size.y
    )

  radioButton


proc checkButton*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultCheckButtonPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),

  fgColor = some(defaultForegroundColor),
  text: string,
  gap = defaultGap,
  font = defaultFont,
  checked = false
): FlammulinaVelutipesWidget =
  let
    size = getMinSize(text, font, minSize, padding)
    width = size.y
    height = size.y

  var checkButton = FlammulinaVelutipesWidget(
    kind: wkCheckButton,
    checkButton: CheckButton(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: minSize,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,
      cornerRadius: none(CornerRadius),

      fgshape: rect(0, 0, width * fgCoeff, height * fgCoeff),
      bgshape: rect(0, 0, width, height),
      fgColor: fgColor,
      gap: gap,
      text: text,
      font: font,
      checked: checked
    )
  )

  checkButton.checkButton.boundaryBox =
    rect(
      0,
      0,
      width + gap + size.x,
      height
    )

  checkButton


proc slider*(
  parent = none(FlammulinaVelutipesWidget),
  name: string,
  padding = defaultSliderPadding,
  margin = defaultMargin,
  minSize = vec2(0, 0),
  maxSize = vec2(0, 0),
  horizontalSizeState = WidgetSizeState.Fixed,
  verticalSizeState = WidgetSizeState.Fixed,
  movable = false,
  bgcolor = some(defaultBackgroundColor),
  border = some(Border(width: 1, color: defaultBorderColor)),
  enabled = true,
  visible = true,
  focused = false,
  hovered = false,
  tooltip = none(Tooltip),

  direction = SliderDirection.Horizontal,
  fgshape = rect(0, 0, 12, 24),
  bgshape = rect(0, 0, 200, 8),
  fgColor = some(defaultForegroundColor),
  valueRange = vec2(0.0, 10.0),
  value = 0.0,
  step = 1.0
): FlammulinaVelutipesWidget =
  var widget = FlammulinaVelutipesWidget(
    kind: wkSlider,
    slider: Slider(
      parent: parent,
      name: name,
      padding: padding,
      margin: margin,
      minSize: minSize,
      maxSize: maxSize,
      horizontalSizeState: horizontalSizeState,
      verticalSizeState: verticalSizeState,
      movable: movable,
      bgcolor: bgcolor,
      border: border,
      enabled: enabled,
      visible: visible,
      focused: focused,
      hovered: hovered,
      tooltip: tooltip,

      direction: direction,
      fgshape: fgshape,
      bgshape: bgshape,
      fgColor: fgColor,
      valueRange: valueRange,
      value: value,
      step: step
    )
  )
  let
    width = max(fgshape.w, bgshape.w)
    height = max(fgshape.h, bgshape.h)
  widget.slider.boundaryBox = rect(0, 0, width, height)
  widget


proc table*(
  name: string,
  headerNames: seq[string],
  rows: int
): FlammulinaVelutipesWidget =
  let headers =
    headerNames.map(
      header =>
        rectPushButton(
          name = name & "_" & header & "_header",
          margin = Margin(left: 1, top: 0, right: 0, bottom: 0),
          cornerRadius = none(CornerRadius),
          text = header
        )
    )

  layout(
    name = name,
    direction = LayoutDirection.Vertical,
    horizontalSizeState = WidgetSizeState.Minimum,
    children = @[
      layout(
        name = name & "_header_layout",
        direction = LayoutDirection.Horizontal,
        children = headers
      )] & 
      (0..<rows).toSeq().map(
        row =>
          layout(
            name = name & "_row_" & $row,
            direction = LayoutDirection.Horizontal,
            children = 
              headers.map(
                header =>
                  lineEdit(
                    name = name & "_" & header.pushButton.text & "_cell_" & $row,
                    margin = Margin(left: 1, top: 1, right: 0, bottom: 0),
                    minSize =
                      vec2(
                        header.pushButton.shape.rect.w,
                        header.pushButton.shape.rect.h
                      ),
                    cornerRadius = none(CornerRadius),
                    text = "",
                    shape = rect(0, 0, 0, 0)
                  )
              )
          )
      )
  )


proc getRootWidget(self: Layout): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkLayout,
      layout: self
    )


proc getRootWidget(self: Label): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkLabel,
      label: self
    )


proc getRootWidget(self: LineEdit): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkLineEdit,
      lineEdit: self
    )


proc getRootWidget(self: RadioButton): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkRadioButton,
      radioButton: self
    )


proc getRootWidget(self: PushButton): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkPushButton,
      pushButton: self
    )


proc getRootWidget(self: CheckButton): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkCheckButton,
      checkButton: self
    )


proc getRootWidget(self: Slider): FlammulinaVelutipesWidget =
  if self.parent.isSome():
    let parent = self.parent.get()
    case parent.kind
    of wkLayout:
      parent.layout.getRootWidget()
    else:
      raise
  else:
    FlammulinaVelutipesWidget(
      kind: wkSlider,
      slider: self
    )


proc getRootWidget(self: FlammulinaVelutipesWidget): FlammulinaVelutipesWidget =
  case self.kind:
  of wkLayout:
    self.layout.getRootWidget()
  of wkLabel:
    self.label.getRootWidget()
  of wkLineEdit:
    self.lineEdit.getRootWidget()
  of wkRadioButton:
    self.radioButton.getRootWidget()
  of wkPushButton:
    self.pushButton.getRootWidget()
  of wkCheckButton:
    self.checkButton.getRootWidget()
  of wkSlider:
    self.slider.getRootWidget()


proc overlaps(layout: Layout, mousePos: IVec2): bool =
  overlaps(layout.boundaryBox, mousePos.vec2)


proc overlaps(label: Label, mousePos: IVec2): bool =
  overlaps(label.boundaryBox, mousePos.vec2)


proc overlaps(lineEdit: LineEdit, mousePos: IVec2): bool =
  overlaps(lineEdit.boundaryBox, mousePos.vec2)


proc overlaps(button: RadioButton, mousePos: IVec2): bool =
  overlaps(button.boundaryBox, mousePos.vec2)


proc overlaps(button: PushButton, mousePos: IVec2): bool =
  case button.shape.kind
  of pbskCircle:
    overlaps(button.shape.circle, mousePos.vec2)
  of pbskRect:
    overlaps(button.shape.rect, mousePos.vec2)


proc overlaps(button: CheckButton, mousePos: IVec2): bool =
  overlaps(button.boundaryBox, mousePos.vec2)


proc overlaps(slider: Slider, mousePos: IVec2): bool =
  case slider.direction
  of Horizontal:
    let
      offsetx =
        slider.value /
        (slider.valueRange[1] - slider.valueRange[0]) *
        slider.bgshape.w

    overlaps(
      rect(
        slider.fgshape.x + offsetx,
        slider.fgshape.y,
        slider.fgshape.w,
        slider.fgshape.h
      ),
      mousePos.vec2
    )
  of Vertical:
    let
      offsety =
        slider.value /
        (slider.valueRange[1] - slider.valueRange[0]) *
        slider.bgshape.h

    overlaps(
      rect(
        slider.fgshape.x,
        slider.fgshape.y + offsety,
        slider.fgshape.w,
        slider.fgshape.h
      ),
      mousePos.vec2
    )


proc overlaps*(widget: FlammulinaVelutipesWidget, mousePos: IVec2): bool =
  case widget.kind
  of wkLayout:
    overlaps(widget.layout, mousePos)
  of wkLabel:
    overlaps(widget.label, mousePos)
  of wkLineEdit:
    overlaps(widget.lineEdit, mousePos)
  of wkRadioButton:
    overlaps(widget.radioButton, mousePos)
  of wkPushButton:
    overlaps(widget.pushButton, mousePos)
  of wkCheckButton:
    overlaps(widget.checkButton, mousePos)
  of wkSlider:
    overlaps(widget.slider, mousePos)


proc minSize*(self: FlammulinaVelutipesWidget): Vec2 =
  case self.kind
  of wkLayout:
    self.layout.minSize
  of wkLabel:
    self.label.minSize
  of wkLineEdit:
    self.lineEdit.minSize
  of wkRadioButton:
    self.radioButton.minSize
  of wkPushButton:
    self.pushButton.minSize
  of wkCheckButton:
    self.checkButton.minSize
  of wkSlider:
    self.slider.minSize


proc enabled*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    self.layout.enabled
  of wkLabel:
    self.label.enabled
  of wkLineEdit:
    self.lineEdit.enabled
  of wkRadioButton:
    self.radioButton.enabled
  of wkPushButton:
    self.pushButton.enabled
  of wkCheckButton:
    self.checkButton.enabled
  of wkSlider:
    self.slider.enabled


proc setEnabled*(self: FlammulinaVelutipesWidget, enabled: bool) =
  case self.kind
  of wkLayout:
    self.layout.enabled = enabled
  of wkLabel:
    self.label.enabled = enabled
  of wkLineEdit:
    self.lineEdit.enabled = enabled
  of wkRadioButton:
    self.radioButton.enabled = enabled
  of wkPushButton:
    self.pushButton.enabled = enabled
  of wkCheckButton:
    self.checkButton.enabled = enabled
  of wkSlider:
    self.slider.enabled = enabled


proc visible*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    self.layout.visible
  of wkLabel:
    self.label.visible
  of wkLineEdit:
    self.lineEdit.visible
  of wkRadioButton:
    self.radioButton.visible
  of wkPushButton:
    self.pushButton.visible
  of wkCheckButton:
    self.checkButton.visible
  of wkSlider:
    self.slider.visible


proc setVisible*(self: FlammulinaVelutipesWidget, visible: bool) =
  case self.kind
  of wkLayout:
    self.layout.visible = visible
  of wkLabel:
    self.label.visible = visible
  of wkLineEdit:
    self.lineEdit.visible = visible
  of wkRadioButton:
    self.radioButton.visible = visible
  of wkPushButton:
    self.pushButton.visible = visible
  of wkCheckButton:
    self.checkButton.visible = visible
  of wkSlider:
    self.slider.visible = visible


proc hovered*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    self.layout.hovered
  of wkLabel:
    self.label.hovered
  of wkLineEdit:
    self.lineEdit.hovered
  of wkRadioButton:
    self.radioButton.hovered
  of wkPushButton:
    self.pushButton.hovered
  of wkCheckButton:
    self.checkButton.hovered
  of wkSlider:
    self.slider.hovered


proc setHovered*(self: FlammulinaVelutipesWidget, hovered: bool) =
  case self.kind
  of wkLayout:
    self.layout.hovered = hovered
  of wkLabel:
    self.label.hovered = hovered
  of wkLineEdit:
    self.lineEdit.hovered = hovered
  of wkRadioButton:
    self.radioButton.hovered = hovered
  of wkPushButton:
    self.pushButton.hovered = hovered
  of wkCheckButton:
    self.checkButton.hovered = hovered
  of wkSlider:
    self.slider.hovered = hovered


proc setHoveredOffRecursively(self: FlammulinaVelutipesWidget) =
  self.setHovered(false)

  case self.kind
  of wkLayout:
    let children = self.layout.children
    for i in 0..<children.len:
      children[i].setHoveredOffRecursively()
  else:
    discard


proc focused*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    self.layout.focused
  of wkLabel:
    self.label.focused
  of wkLineEdit:
    self.lineEdit.focused
  of wkRadioButton:
    self.radioButton.focused
  of wkPushButton:
    self.pushButton.focused
  of wkCheckButton:
    self.checkButton.focused
  of wkSlider:
    self.slider.focused


proc setFocused*(self: FlammulinaVelutipesWidget, focused: bool) =
  case self.kind
  of wkLayout:
    self.layout.focused = focused
  of wkLabel:
    self.label.focused = focused
  of wkLineEdit:
    self.lineEdit.focused = focused
  of wkRadioButton:
    self.radioButton.focused = focused
  of wkPushButton:
    self.pushButton.focused = focused
  of wkCheckButton:
    self.checkButton.focused = focused
  of wkSlider:
    self.slider.focused = focused


proc setFocusedOffRecursively(self: FlammulinaVelutipesWidget) =
  self.setFocused(false)

  case self.kind
  of wkLayout:
    let children = self.layout.children
    for i in 0..<children.len:
      children[i].setFocusedOffRecursively()
  else:
    discard


proc updated*(self: FlammulinaVelutipesWidget): bool =
  case self.kind:
  of wkLayout:
    self.layout.updated
  of wkLabel:
    self.label.updated
  of wkLineEdit:
    self.lineEdit.updated
  of wkRadioButton:
    self.radioButton.updated
  of wkPushButton:
    self.pushButton.updated
  of wkCheckButton:
    self.checkButton.updated
  of wkSlider:
    self.slider.updated


proc onClicked(self: LineEdit) =
  self.getRootWidget().setFocusedOffRecursively()
  self.focused = true


proc onClicked(self: RadioButton) =
  self.getRootWidget().setFocusedOffRecursively()
  for i in 0..<self.group.len:
    if self.group[i].name == self.name:
      self.group[i].checked = true
      self.group[i].focused = true
    else:
      self.group[i].checked = false


proc onClickedOuter(self: PushButton) =
  self.getRootWidget().setFocusedOffRecursively()
  self.pushed = true
  self.focused = true
  self.onClicked()


proc onClicked(self: CheckButton) =
  self.getRootWidget().setFocusedOffRecursively()
  self.checked = not self.checked
  self.focused = true


proc onClicked(self: Slider) =
  self.getRootWidget().setFocusedOffRecursively()
  self.dragged = true
  self.focused = true


proc onClicked*(self: FlammulinaVelutipesWidget, mousePos: IVec2) =
  if self.enabled() and self.visible() and overlaps(self, mousePos):
    case self.kind
    of wkLayout:
      let children = self.layout.children
      for child in children:
        if child.enabled() and child.visible() and overlaps(child, mousePos):
          child.onClicked(mousePos)
    of wkLabel:
      discard
    of wkLineEdit:
      self.lineEdit.onClicked()
    of wkRadioButton:
      self.radioButton.onClicked()
    of wkPushButton:
      self.pushButton.onClickedOuter()
    of wkCheckButton:
      self.checkButton.onClicked()
    of wkSlider:
      self.slider.onClicked()


proc onMouseMoved(self: Slider, mousePos: IVec2): bool =
  if not self.dragged:
    return false

  case self.direction
  of Horizontal:
    let
      currentX = min(max(mousePos.x.float32 - self.bgshape.x, 0), self.bgshape.w)
      diffValue = self.valueRange[1] - self.valueRange[0]
      currentValue = self.valueRange[0] + diffValue * currentX / self.bgshape.w
    self.value = currentValue
  of Vertical:
    let
      currentY = min(max(mousePos.y.float32 - self.bgshape.y, 0), self.bgshape.h)
      diffValue = self.valueRange[1] - self.valueRange[0]
      currentValue = self.valueRange[0] + diffValue * currentY / self.bgshape.h
    self.value = currentValue
  true


proc onMouseMoved*(self: FlammulinaVelutipesWidget, mousePos: IVec2): bool =
  if self.enabled() and self.visible():
    case self.kind
    of wkLayout:
      let children = self.layout.children
      for child in children:
        if child.enabled() and child.visible():
          let res = child.onMouseMoved(mousePos)
          if res:
            return true
      false
    of wkLabel:
      false
    of wkLineEdit:
      false
    of wkRadioButton:
      false
    of wkPushButton:
      false
    of wkCheckButton:
      false
    of wkSlider:
      return self.slider.onMouseMoved(mousePos)


proc onButtonReleased(self: Slider, mousePos: IVec2): bool =
  self.dragged = false
  true


proc onButtonReleased*(self: FlammulinaVelutipesWidget, mousePos: IVec2): bool =
  if self.enabled() and self.visible():
    case self.kind
    of wkLayout:
      let children = self.layout.children
      for child in children:
        if child.enabled() and child.visible():
          let res = child.onButtonReleased(mousePos)
          if res:
            return true
      false
    of wkLabel:
      false
    of wkLineEdit:
      false
    of wkRadioButton:
      false
    of wkPushButton:
      false
    of wkCheckButton:
      false
    of wkSlider:
      return self.slider.onButtonReleased(mousePos)


proc onHovered*(self: FlammulinaVelutipesWidget, mousePos: IVec2): bool =
  if self.enabled() and self.visible() and overlaps(self, mousePos):
    if self.kind == wkLayout:
      let children = self.layout.children
      for child in children:
        let hovered = child.onHovered(mousePos)
        if hovered:
          return true

    self.getRootWidget().setHoveredOffRecursively()
    self.setHovered(true)
    true
  else:
    false


proc setBoundaryBox(self: var Label, x, y: float32) =
  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: self.shape.w,
    h: self.shape.h
  )
  self.shape = self.boundaryBox
  self.minSize = vec2(self.shape.w, self.shape.h)

  # echo "Label boundary box: " & $self.boundaryBox
  # echo "Label shape: " & $self.shape


proc setBoundaryBox(self: var LineEdit, x, y: float32) =
  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: self.shape.w,
    h: self.shape.h
  )
  self.shape = self.boundaryBox
  self.minSize = vec2(self.shape.w, self.shape.h)
  self.cursor.shape =
    rect(
      x + self.padding.left,
      y + self.padding.top,
      self.cursor.shape.w,
      self.cursor.shape.h
    )

  # echo "LineEdit boundary box: " & $self.boundaryBox
  # echo "LineEdit shape: " & $self.shape


proc setBoundaryBox(self: var RadioButton, x, y: float32) =
  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: self.boundaryBox.w,
    h: self.boundaryBox.h
  )
  self.minSize = vec2(self.boundaryBox.w, self.boundaryBox.h)

  # echo "RadioButton boundary box: " & $self.boundaryBox


proc getSize(self: PushButton): (float32, float32) =
  case self.shape.kind
  of pbskCircle:
    (2 * self.shape.circle.radius, 2 * self.shape.circle.radius)

  of pbskRect:
    (self.shape.rect.w, self.shape.rect.h)


proc setBoundaryBox(self: var PushButton, x, y: float32) =
  let (width, height) = self.getSize()

  case self.shape.kind
  of pbskCircle:
    self.shape.circle = Circle(
      pos: vec2(
        x + self.shape.circle.radius,
        y + self.shape.circle.radius
      ),
      radius: self.shape.circle.radius
    )
    # echo $self.shape.circle

  of pbskRect:
    self.shape.rect = Rect(
      x: x,
      y: y,
      w: width,
      h: height
    )
    # echo $self.shape.rect

  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: width,
    h: height
  )
  self.minSize = vec2(width, height)

  # echo "PushButton boundary box: " & $self.boundaryBox
  # echo "PushButton shape: " & $self.shape.kind


proc setBoundaryBox(self: var CheckButton, x, y: float32) =
  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: self.boundaryBox.w,
    h: self.boundaryBox.h
  )
  self.minSize = vec2(self.boundaryBox.w, self.boundaryBox.h)

  # echo "CheckButton boundary box: " & $self.boundaryBox


proc setBoundaryBox(self: var Slider, x, y: float32) =
  self.boundaryBox = Rect(
    x: x,
    y: y,
    w: self.boundaryBox.w,
    h: self.boundaryBox.h
  )
  self.minSize = vec2(self.boundaryBox.w, self.boundaryBox.h)
  self.fgshape =
    rect(
      x - self.fgshape.w / 2,
      y,
      self.fgshape.w,
      self.fgshape.h
    )
  self.bgshape =
    rect(
      x,
      y + (self.boundaryBox.h - self.bgshape.h) / 2,
      self.bgshape.w,
      self.bgshape.h
    )

  # echo "Slider boundary box: " & $self.boundaryBox


proc setBoundaryBox*(self: var FlammulinaVelutipesWidget, x, y: float32) {.cdecl.}

proc setBoundaryBox(self: var Layout, x, y: float32) =
  if not self.visible:
    return

  case self.direction
  of LayoutDirection.Horizontal:
    var
      selfWidth = 0.0
      selfHeight = 0.0
      childx = x + self.padding.left

    let childy = y + self.padding.top

    var children = self.children 
    for i in 0..<children.len:
      if not children[i].visible():
        continue

      let margin = children[i].getMargin()
      children[i].setBoundaryBox(childx + margin.left, childy + margin.top)

      let boundaryBox = children[i].getBoundaryBox()
      childx += margin.left + boundaryBox.w + margin.right

      let childHeight = margin.top + boundaryBox.h + margin.bottom

      if childHeight > selfHeight:
        selfHeight = childHeight
  
    selfWidth = childx - x + self.padding.right
    selfHeight += self.padding.top + self.padding.bottom
    self.boundaryBox =
      Rect(
        x: x,
        y: y,
        w: selfWidth,
        h: selfHeight
      )
    self.minSize = vec2(selfWidth, selfHeight)

  of LayoutDirection.Vertical:
    var
      selfWidth = 0.0
      selfHeight = 0.0
      childy = y + self.padding.top

    let childx = x + self.padding.left

    var children = self.children 
    for i in 0..<children.len:
      if not children[i].visible():
        continue

      let margin = children[i].getMargin()
      children[i].setBoundaryBox(childx + margin.left, childy + margin.top)

      let boundaryBox = children[i].getBoundaryBox()
      childy += margin.top + boundaryBox.h + margin.bottom

      let childWidth = margin.left + boundaryBox.w + margin.right

      if childWidth > selfWidth:
        selfWidth = childWidth

    selfWidth += self.padding.left + self.padding.right
    selfHeight = childy - y + self.padding.bottom
    self.boundaryBox =
      Rect(
        x: x,
        y: y,
        w: selfWidth,
        h: selfHeight
      )
    self.minSize = vec2(selfWidth, selfHeight)

  # echo "Layout direction: " & $self.direction
  # echo "Layout boundary box: " & $self.boundaryBox


proc setBoundaryBox*(self: var FlammulinaVelutipesWidget, x, y: float32) =
  case self.kind
  of wkLayout:
    self.layout.setBoundaryBox(x, y)
  of wkLabel:
    self.label.setBoundaryBox(x, y)
  of wkLineEdit:
    self.lineEdit.setBoundaryBox(x, y)
  of wkRadioButton:
    self.radioButton.setBoundaryBox(x, y)
  of wkPushButton:
    self.pushButton.setBoundaryBox(x, y)
  of wkCheckButton:
    self.checkButton.setBoundaryBox(x, y)
  of wkSlider:
    self.slider.setBoundaryBox(x, y)


proc setAlignment(self: var Layout, x, y, width, height: float32) =
  var children = self.children

  case self.direction
  of LayoutDirection.Horizontal:
    var childx = x + self.padding.left

    case self.verticalAlignment
    of LayoutVerticalAlignment.Top:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childx += children[i].getMarginLeft()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              children[i].getBoundaryBoxWidth()

            childHeight =
              case children[i].layout.verticalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxHeight() -
                  children[i].getMarginTop() -
                  children[i].getMarginBottom()
                else:
                  children[i].getBoundaryBoxHeight()

            childy = y + self.padding.top + children[i].getMarginTop()

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childx += childWidth + children[i].getMarginRight()

        else:
          let
            childWidth = children[i].getBoundaryBoxWidth()
            childy = y + self.padding.top + children[i].getMarginTop()

          children[i].setBoundaryBox(childx, childy)
          childx += childWidth + children[i].getMarginRight()

      let selfWidth =
        case self.horizontalSizeState
        of Minimum:
          childx + self.padding.right - x
        else:
          width

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: selfWidth,
        h: height
      )

    of LayoutVerticalAlignment.Center:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childx += children[i].getMarginLeft()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              children[i].getBoundaryBoxWidth()

            childHeight =
              case children[i].layout.verticalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxHeight() -
                  children[i].getMarginTop() -
                  children[i].getMarginBottom()
                else:
                  children[i].getBoundaryBoxHeight()

            childy = y + (height - childHeight) / 2

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childx += childWidth + children[i].getMarginRight()

        else:
          let
            (childWidth, childHeight) = children[i].getBoundaryBoxSize()
            childy = y + (height - childHeight) / 2

          children[i].setBoundaryBox(childx, childy)
          childx += childWidth + children[i].getMarginRight()

      let selfWidth =
        case self.horizontalSizeState
        of Minimum:
          childx + self.padding.right - x
        else:
          width

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: selfWidth,
        h: height
      )

    of LayoutVerticalAlignment.Bottom:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childx += children[i].getMarginLeft()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              children[i].getBoundaryBoxWidth()

            childHeight =
              case children[i].layout.verticalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxHeight()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxHeight() -
                  children[i].getMarginTop() -
                  children[i].getMarginBottom()
                else:
                  children[i].getBoundaryBoxHeight()

            childy =
              y +
              height -
              childHeight -
              self.padding.bottom -
              children[i].getMarginBottom()

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childx += childWidth + children[i].getMarginRight()

        else:
          let
            (childWidth, childHeight) = children[i].getBoundaryBoxSize()
            childy =
              y +
              height -
              childHeight -
              self.padding.bottom -
              children[i].getMarginBottom()

          children[i].setBoundaryBox(childx, childy)
          childx += childWidth + children[i].getMarginRight()

      let selfWidth =
        case self.horizontalSizeState
        of Minimum:
          childx + self.padding.right - x
        else:
          width

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: selfWidth,
        h: height
      )

  of LayoutDirection.Vertical:
    var childy = y + self.padding.top

    case self.horizontalAlignment
    of LayoutHorizontalAlignment.Left:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childy += children[i].getMarginTop()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              case children[i].layout.horizontalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxWidth() -
                  children[i].getMarginLeft() -
                  children[i].getMarginRight()
                else:
                  children[i].getBoundaryBoxWidth()

            childHeight =
              children[i].getBoundaryBoxHeight()

            childx = x + self.padding.left + children[i].getMarginLeft()

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childy += childHeight + children[i].getMarginBottom()

        else:
          let
            childHeight = children[i].getBoundaryBoxHeight()
            childx = x + self.padding.left + children[i].getMarginLeft()

          children[i].setBoundaryBox(childx, childy)
          childy += childHeight + children[i].getMarginBottom()

      let selfHeight =
        case self.verticalSizeState
        of Minimum:
          childy + self.padding.bottom - y
        else:
          height

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: width,
        h: selfHeight
      )

    of LayoutHorizontalAlignment.Center:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childy += children[i].getMarginTop()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              case children[i].layout.horizontalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxWidth() -
                  children[i].getMarginLeft() -
                  children[i].getMarginRight()
                else:
                  children[i].getBoundaryBoxWidth()

            childHeight =
              children[i].getBoundaryBoxHeight()

            childx = x + (width - childWidth) / 2

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childy += childHeight + children[i].getMarginBottom()

        else:
          let
            (childWidth, childHeight) = children[i].getBoundaryBoxSize()
            childx = x + (width - childWidth) / 2

          children[i].setBoundaryBox(childx, childy)
          childy += childHeight + children[i].getMarginBottom()

      let selfHeight =
        case self.verticalSizeState
        of Minimum:
          childy + self.padding.bottom - y
        else:
          height

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: width,
        h: selfHeight
      )

    of LayoutHorizontalAlignment.Right:
      for i in 0..<children.len:
        if not children[i].visible():
          continue

        childy += children[i].getMarginTop()

        case children[i].kind
        of wkLayout:
          let
            childWidth =
              case children[i].layout.horizontalSizeState
              of WidgetSizeState.Fixed:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Minimum:
                children[i].getBoundaryBoxWidth()
              of WidgetSizeState.Expand:
                if children[i].layout.parent.isSome():
                  let parent = children[i].layout.parent.get()
                  parent.getBoundaryBoxWidth() -
                  children[i].getMarginLeft() -
                  children[i].getMarginRight()
                else:
                  children[i].getBoundaryBoxWidth()

            childHeight =
              children[i].getBoundaryBoxHeight()

            childx =
              x +
              width -
              childWidth -
              self.padding.right -
              children[i].getMarginRight()

          children[i].layout.boundaryBox = Rect(
            x: childx,
            y: childy,
            w: childWidth,
            h: childHeight
          )
          children[i].layout.setAlignment(childx, childy, childWidth, childHeight)
          childy += childHeight + children[i].getMarginBottom()

        else:
          let
            (childWidth, childHeight) = children[i].getBoundaryBoxSize()
            childx =
              x +
              width -
              childWidth -
              self.padding.right -
              children[i].getMarginRight()

          children[i].setBoundaryBox(childx, childy)
          childy += childHeight + children[i].getMarginBottom()

      let selfHeight =
        case self.verticalSizeState
        of Minimum:
          childy + self.padding.bottom - y
        else:
          height

      self.boundaryBox = Rect(
        x: x,
        y: y,
        w: width,
        h: selfHeight
      )


proc setAlignment*(self: var FlammulinaVelutipesWidget, windowSize: IVec2) =
  if not self.visible():
    return

  case self.kind
  of wkLayout:
    let
      (x, y) = self.getAbsolutePosition()
      width =
        case self.layout.horizontalSizeState
        of WidgetSizeState.Fixed:
          self.getBoundaryBoxWidth()
        of WidgetSizeState.Minimum:
          self.getBoundaryBoxWidth()
        of WidgetSizeState.Expand:
          if self.layout.parent.isSome():
            let parent = self.layout.parent.get()
            parent.getBoundaryBoxWidth() -
            self.getMarginLeft() -
            self.getMarginRight()
          else:
            windowSize.x.float32 -
            self.getMarginLeft() -
            self.getMarginRight() 

      height =
        case self.layout.verticalSizeState
        of WidgetSizeState.Fixed:
          self.getBoundaryBoxHeight()
        of WidgetSizeState.Minimum:
          self.getBoundaryBoxHeight()
        of WidgetSizeState.Expand:
          if self.layout.parent.isSome():
            let parent = self.layout.parent.get()
            parent.getBoundaryBoxHeight() -
            self.getMarginTop() -
            self.getMarginBottom()
          else:
            windowSize.y.float32 -
            self.getMarginTop() -
            self.getMarginBottom()

    self.layout.boundaryBox = Rect(x: x, y: y, w: width, h: height)
    self.layout.setAlignment(x, y, width, height)
  else:
    discard


proc setLayout*(self: var FlammulinaVelutipesWidget, windowSize: IVec2) =
  let (x, y) = (self.getmarginLeft(), self.getMarginTop())
  self.setBoundaryBox(x, y)
  self.setAlignment(windowSize)


func name(self: FlammulinaVelutipesWidget): string =
  case self.kind
  of wkLayout:
    self.layout.name
  of wkLabel:
    self.label.name
  of wkLineEdit:
    self.lineEdit.name
  of wkRadioButton:
    self.radioButton.name
  of wkPushButton:
    self.pushButton.name
  of wkCheckButton:
    self.checkButton.name
  of wkSlider:
    self.slider.name


func getElementByID*(
  self: FlammulinaVelutipesWidget,
  name: string
): Option[FlammulinaVelutipesWidget] =
  if self.name() == name:
    return some(self)

  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let res = child.getElementByID(name)
      if res.isSome():
        return res
    return none(FlammulinaVelutipesWidget)
  else:
    return none(FlammulinaVelutipesWidget)


proc setCursorPositon(self: LineEdit) =
  let size = self.font.layoutBounds(self.text[0..<self.currentIndex])
  self.cursor.shape =
    rect(
      self.boundaryBox.x + self.padding.left + size.x,
      self.boundaryBox.y + self.padding.top,
      self.cursor.shape.w,
      self.cursor.shape.h
    )


proc onKeyPress*(self: FlammulinaVelutipesWidget, text: string): bool =
  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let pressed = child.onKeyPress(text)
      if pressed:
        return true
    return false
  of wkLineEdit:
    if self.focused:
      let currentIndex = self.lineEdit.currentIndex
      self.lineEdit.text =
        self.lineEdit.text[0..<currentIndex] &
        text &
        self.lineEdit.text[currentIndex..<self.lineEdit.text.len]
      self.lineEdit.currentIndex += 1
      self.lineEdit.setCursorPositon()
      self.lineEdit.updated = true
      # echo self.lineEdit.text
      true
    else:
      false
  else:
    false


proc onKeyBackSpacePress*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let pressed = child.onKeyBackSpacePress()
      if pressed:
        return true
    return false
  of wkLineEdit:
    if self.focused and self.lineEdit.text.len > 0:
      if self.lineEdit.currentIndex > 0:
        let currentIndex = self.lineEdit.currentIndex
        self.lineEdit.text =
          self.lineEdit.text[0..<currentIndex - 1] &
          self.lineEdit.text[currentIndex..<self.lineEdit.text.len]
        self.lineEdit.currentIndex -= 1
        # echo self.lineEdit.text
        self.lineEdit.setCursorPositon()
        self.lineEdit.updated = true
        # echo "current index: " & $self.lineEdit.currentIndex
      return true
    else:
      return false
  else:
    return false


proc onKeyDeletePress*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let pressed = child.onKeyDeletePress()
      if pressed:
        return true
    return false
  of wkLineEdit:
    if self.focused:
      if
        self.lineEdit.text.len > 0 and
        self.lineEdit.currentIndex < self.lineEdit.text.len:

        let currentIndex = self.lineEdit.currentIndex
        self.lineEdit.text =
          self.lineEdit.text[0..<currentIndex] &
          self.lineEdit.text[currentIndex + 1..<self.lineEdit.text.len]
        self.lineEdit.updated = true
        # echo self.lineEdit.text
        # echo "current index: " & $self.lineEdit.currentIndex
      return true
    else:
      return false
  else:
    return false


proc onKeyLeftPress*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let pressed = child.onKeyLeftPress()
      if pressed:
        return true
    return false
  of wkLineEdit:
    if self.focused:
      if self.lineEdit.text.len > 0 and self.lineEdit.currentIndex > 0:
        self.lineEdit.currentIndex -= 1
        self.lineEdit.setCursorPositon()
        self.lineEdit.updated = true
        # echo "current index: " & $self.lineEdit.currentIndex
      return true
    else:
      return false
  of wkSlider:
    if self.focused:
      if self.slider.value > self.slider.valueRange[0]:
        self.slider.value =
          max(self.slider.value - self.slider.step, self.slider.valueRange[0])
      return true
    else:
      return false
  else:
    return false


proc onKeyRightPress*(self: FlammulinaVelutipesWidget): bool =
  case self.kind
  of wkLayout:
    for child in self.layout.children:
      let pressed = child.onKeyRightPress()
      if pressed:
        return true
    return false
  of wkLineEdit:
    if self.focused:
      if
        self.lineEdit.text.len > 0 and
        self.lineEdit.currentIndex < self.lineEdit.text.len:

        self.lineEdit.currentIndex += 1
        self.lineEdit.setCursorPositon()
        self.lineEdit.updated = true
        # echo "current index: " & $self.lineEdit.currentIndex
      return true
    else:
      return false
  of wkSlider:
    if self.focused:
      if self.slider.value < self.slider.valueRange[1]:
        self.slider.value =
          min(self.slider.value + self.slider.step, self.slider.valueRange[1])
      return true
    else:
      return false
  else:
    return false
