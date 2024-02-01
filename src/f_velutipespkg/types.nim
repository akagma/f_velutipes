import std/options

import boxy
import bumpy
import windy


type
  Padding* = object
    top*: float32
    right*: float32
    bottom*: float32
    left*: float32
  
  Margin* = object
    top*: float32
    right*: float32
    bottom*: float32
    left*: float32
 
  WidgetColor* = object
    enabled*: Color
    disabled*: Color
    hover*: Color

  WidgetSizeState* {.pure.} = enum
    Fixed
    Minimum
    Expand

  Border* = object
    width*: float32
    color*: Color

  CornerRadius* = object
    leftTop*: float32
    rightTop*: float32
    leftBottom*: float32
    rightBottom*: float32

  TooltipObj = object
    text*: string
    font*: Font
    color*: Color
    size*: Vec2
    padding*: Padding
    margin*: Margin
    horizontalAlignment*: HorizontalAlignment
    verticalAlignment*: VerticalAlignment
    cornerRadius*: Option[CornerRadius]

  Tooltip* = ref TooltipObj

  WidgetBaseObj = object of RootObj
    parent*: Option[FlammulinaVelutipesWidget]
    name*: string
    padding*: Padding
    margin*: Margin
    minSize*: Vec2
    maxSize*: Vec2
    boundaryBox*: Rect = Rect(x: 0, y: 0, w: 0, h: 0)
    horizontalSizeState*: WidgetSizeState
    verticalSizeState*: WidgetSizeState
    movable*: bool
    bgcolor*: Option[WidgetColor]
    border*: Option[Border]
    enabled*: bool
    visible*: bool
    focused*: bool
    hovered*: bool
    tooltip*: Option[Tooltip]
    updated*: bool = false
    cornerRadius*: Option[CornerRadius]

  LayoutDirection* {.pure.} = enum
    Horizontal
    Vertical

  LayoutHorizontalAlignment* {.pure.} = enum
    Left
    Center
    Right

  LayoutVerticalAlignment* {.pure.} = enum
    Top
    Center
    Bottom

  LayoutObj = object of WidgetBaseObj
    direction*: LayoutDirection
    children*: seq[FlammulinaVelutipesWidget]
    horizontalAlignment*: LayoutHorizontalAlignment
    verticalAlignment*: LayoutVerticalAlignment

  Layout* = ref LayoutObj

  LabelObj = object of WidgetBaseObj
    shape*: Rect
    text*: string
    font*: Font
    horizontalAlignment*: HorizontalAlignment
    verticalAlignment*: VerticalAlignment

  Label* = ref LabelObj

  PlaceholderObj = object
    text*: string
    font*: Font
  
  Placeholder* = ref PlaceholderObj

  TextCursorObj = object
    shape*: Rect
    color*: Color
  
  TextCursor* = ref TextCursorObj

  LineEditObj = object of WidgetBaseObj
    shape*: Rect
    text*: string
    font*: Font
    placeholder*: Option[Placeholder]
    horizontalAlignment*: HorizontalAlignment
    verticalAlignment*: VerticalAlignment
    currentIndex*: int
    cursor*: TextCursor
    cursorVisible*: bool
    cursorWait*: int
    cursorWaitMax*: int
  
  LineEdit* = ref LineEditObj

  RadioButtonObj = object of WidgetBaseObj
    fgshape*: Circle
    bgshape*: Circle
    fgcolor*: Option[WidgetColor]
    gap*: float32
    text*: string
    font*: Font
    group*: seq[RadioButton]
    checked*: bool

  RadioButton* = ref RadioButtonObj

  PushButtonShapeKind* = enum
    pbskCircle
    pbskRect

  PushButtonShape* = object
    case kind*: PushButtonShapeKind
    of pbskCircle:
      circle*: Circle
    of pbskRect:
      rect*: Rect

  PushButtonObj = object of WidgetBaseObj
    shape*: PushButtonShape
    text*: string
    font*: Font
    onClicked*: proc()
    pushed*: bool = false
    pushWait*: int = 0
    pushWaitMax*: int = 2
  
  PushButton* = ref PushButtonObj

  CheckButtonObj = object of WidgetBaseObj
    fgshape*: Rect
    bgshape*: Rect
    fgcolor*: Option[WidgetColor]
    gap*: float32
    text*: string
    font*: Font
    checked*: bool

  CheckButton* = ref CheckButtonObj

  SliderDirection* {.pure.} = enum
    Horizontal
    Vertical

  SliderObj = object of WidgetBaseObj
    direction*: SliderDirection
    fgshape*: Rect
    bgshape*: Rect
    fgcolor*: Option[WidgetColor]
    valueRange*: Vec2
    value*: float32
    step*: float32
    dragged*: bool = false

  Slider* = ref SliderObj

  FlammulinaVelutipesWidgetKind* = enum
    wkLayout
    wkLabel
    wkLineEdit
    wkPushButton
    wkRadioButton
    wkCheckButton
    wkSlider

  FlammulinaVelutipesWidget* = ref object
    case kind*: FlammulinaVelutipesWidgetKind
    of wkLayout:
      layout*: Layout
    of wkLabel:
      label*: Label
    of wkLineEdit:
      lineEdit*: LineEdit
    of wkRadioButton:
      radioButton*: RadioButton
    of wkPushButton:
      pushButton*: PushButton
    of wkCheckButton:
      checkButton*: CheckButton
    of wkSlider:
      slider*: Slider

  WindowManagerObj = object
    window*: Window
    boxy*: Boxy
    rootWidget*: FlammulinaVelutipesWidget
    children*: seq[WindowManager]
    modal*: bool
  
  WindowManager* = ref WindowManagerObj
