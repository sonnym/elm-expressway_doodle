module Doodle.Model where

import Array (Array, repeat)
import Color (..)
import List (length)
import Signal (Signal, constant)

type alias Grid = Array (Array Color)

state : Signal Grid
state = constant initial

initial : Grid
initial =
  repeat
    (displayWidth // pixelSize)
    (repeat (canvasHeight // pixelSize) white)

swatchSize = 50
palettePadding = 10
pixelSize = 2

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
