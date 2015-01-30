module Doodle.Model where

import Color (..)
import List (length)

swatchSize = 50
palettePadding = 10

displayWidth : Int
displayWidth =
  let
    colorCount = length colors
  in
    ((colorCount - 1) * palettePadding) + (colorCount * swatchSize)

canvasHeight : Int
canvasHeight = displayWidth * 9 // 16

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
