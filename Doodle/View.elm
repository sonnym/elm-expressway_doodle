module Doodle.View where

import List

import Color (..)
import Graphics.Collage (..)
import Graphics.Element (..)

swatchSize = 50
palettePadding = 10

view : Element
view = flow down [palette, (spacer 0 10), canvas]

palette : Element
palette =
  flow right
    (List.intersperse (spacer palettePadding swatchSize)
      (List.map swatch colors))

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

swatch : Color -> Element
swatch color =
  let
    filledSquare = filled color (square (swatchSize - 1))
    border = outlined (solid charcoal) (square swatchSize)
  in
    collage swatchSize swatchSize [filledSquare, border]

colors : List Color
colors =
  [ lightRed, red, darkRed
  , lightOrange, orange, darkOrange
  , lightYellow, yellow, darkYellow
  , lightGreen, green, darkGreen
  , lightBlue, blue, darkBlue
  , lightPurple, purple, darkPurple
  , brown, white, black
  ]
