module Doodle.Decoder (decode) where

import Color (Color, rgb)

decode : (Int, Int, Int) -> Color
decode (r, g, b) = rgb r g b
