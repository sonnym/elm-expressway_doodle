module Doodle.View where

import List

import Color (..)
import Graphics.Element (..)

view : Element
view = flow right (List.intersperse (spacer 5 20) (List.map swath colors))

swath : Color -> Element
swath c = color c (spacer 20 20)

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
