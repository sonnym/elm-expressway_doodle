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

view : (Int, Int) -> Element
view (width,height) =
  let
    view = flow down [palette, (spacer 0 10), canvas]

    viewWidth = toFloat ((widthOf view) + 100)
    viewHeight = toFloat ((heightOf view) + 100)

    scaleFactor = min ((toFloat width) / viewWidth) ((toFloat height) / viewHeight)
  in
    collage width height [view |> toForm |> scale scaleFactor]

palette : Element
palette =
  flow right
    (List.intersperse (spacer palettePadding swatchSize)
      (List.map swatchButton colors))

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

swatchButton : Color -> Element
swatchButton color =
  let
    elem = swatch color
  in
    customButton (send colorSelection color) elem elem elem

swatch : Color -> Element
swatch color =
  let
    filledSquare = filled color (square (swatchSize - 1))
    border = outlined (solid charcoal) (square swatchSize)
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
