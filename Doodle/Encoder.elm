module Doodle.Encoder (encode, color2tuple) where

import Color (Color, toRgb)

encode : ((Int, Int), Color) -> ((Int, Int), (Int, Int, Int))
encode (position, color) = (position, color2tuple color)

color2tuple : Color -> (Int, Int, Int)
color2tuple color =
  let
    components = toRgb color
  in
    (components.red, components.green, components.blue)
