module Doodle.View where

import List

import Color (..)
import Graphics.Element (..)

swathSize = 25

view : Element
view = flow right (List.intersperse (spacer 5 swathSize) (List.map swath colors))

swath : Color -> Element
swath c = color c (spacer swathSize swathSize)

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
