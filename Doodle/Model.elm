module Doodle.Model where

import Array (Array, repeat)
import Color (..)
import List (length)
import Signal (Signal, Channel, channel, subscribe, constant, map2, dropRepeats)

type alias Grid = Array (Array Color)

state : Signal Grid
state = constant initial

initial : Grid
initial =
  repeat
    (displayWidth // pixelSize)
    (repeat (canvasHeight // pixelSize) lightBlue)

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

colorString : Color -> String
colorString color =
  if | color == lightRed -> "#ef2929"
     | color == red -> "#cc0000"
     | color == darkRed -> "#a40000"
     | color == darkOrange -> "#ce5c00"
     | color == orange -> "#f57900"
     | color == lightOrange -> "#fcaf3e"
     | color == lightYellow -> "#fce94f"
     | color == yellow -> "edd400"
     | color == darkYellow -> "#c4a000"
     | color == darkGreen -> "#fe9a06"
     | color == green -> "#73d216"
     | color == lightGreen -> "#8ae234"
     | color == lightBlue -> "#729fcf"
     | color == blue -> "#3465a4"
     | color == darkBlue -> "#204a87"
     | color == darkPurple -> "#5c3566"
     | color == purple -> "#75507b"
     | color == lightPurple -> "#ad7fad"
     | color == brown -> "#c17d11"
     | color == white -> "#ffffff"
     | color == black -> "#000000"

colorSelection : Channel Color
colorSelection = channel lightRed

paint : Channel (Int, Int)
paint = channel (-1, -1)
