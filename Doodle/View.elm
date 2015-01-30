module Doodle.View where

import Text -- prevent compiler error (https://github.com/elm-lang/core/issues/93)

import List
import Signal (Channel, channel, send)

import Color (..)
import Graphics.Collage (..)
import Graphics.Element (..)
import Graphics.Input (customButton)

swatchSize = 50
palettePadding = 10

view : (Int, Int) -> Color -> Element
view (width,height) selected =
  let
    view = flow down [palette selected, (spacer 0 10), canvas]

    viewWidth = toFloat ((widthOf view) + 100)
    viewHeight = toFloat ((heightOf view) + 100)

    scaleFactor = min ((toFloat width) / viewWidth) ((toFloat height) / viewHeight)
  in
    collage width height [view |> toForm |> scale scaleFactor]

palette : Color -> Element
palette selected =
  flow right
    (List.intersperse (spacer palettePadding swatchSize)
      (List.map (swatchButton selected) colors))

canvas : Element
canvas =
  let
    colorCount = List.length colors

    width = ((colorCount - 1) * palettePadding) + (colorCount * swatchSize)
    height = (width * 9 // 16)

    floatWidth = toFloat width
    floatHeight = toFloat height
  in
    collage width height
      [rect floatWidth floatHeight
        |> outlined (solid black)]

swatchButton : Color -> Color -> Element
swatchButton selected color =
  let
    elem = swatch selected color
  in
    customButton (send colorSelection color) elem elem elem

swatch : Color -> Color -> Element
swatch selected color =
  let
    lineWidth = if selected == color then 10 else 1

    baseLineStyle = solid charcoal
    lineStyle = { baseLineStyle | width <- lineWidth }

    filledSquare = filled color (square swatchSize)
    border = outlined lineStyle (square swatchSize)
  in
    collage swatchSize swatchSize [filledSquare, border]

colorSelection : Channel Color
colorSelection = channel darkRed

colors : List Color
colors =
  [ lightRed, red, darkRed
  , darkOrange, orange, lightOrange
  , lightYellow, yellow, darkYellow
  , darkGreen, green, lightGreen
  , lightBlue, blue, darkBlue
  , darkPurple, purple, lightPurple
  , brown, white, black
  ]
