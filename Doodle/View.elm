module Doodle.View where

import Array
import Text (asText, plainText)

import List ((::), intersperse, map, foldl)
import Signal (Channel, channel, send)

import Color (Color, black, lightCharcoal, lightRed)
import Graphics.Collage (..)
import Graphics.Element (..)
import Graphics.Input (customButton)

import Doodle.Model (Grid, displayWidth, canvasHeight, colors, swatchSize, palettePadding)

view : (Int, Int) -> Color -> Grid -> Element
view (width,height) selected grid =
  let
    padding = spacer 0 10
    view = flow down [palette selected, padding, canvas grid, padding, footer]

    viewWidth = toFloat ((widthOf view) + 100)
    viewHeight = toFloat ((heightOf view) + 100)

    scaleFactor = min ((toFloat width) / viewWidth) ((toFloat height) / viewHeight)
  in
    collage width height [view |> toForm |> scale scaleFactor]

palette : Color -> Element
palette selected =
  flow right
    (intersperse (spacer palettePadding swatchSize)
      (map (swatchButton selected) colors))

canvas : Grid -> Element
canvas grid =
  flow left (map (\col ->
    flow down (map (\clr -> color clr (spacer 1 1)) (Array.toList col)))
  (Array.toList grid))

footer : Element
footer =
  container displayWidth 20 middle (flow right
    [ plainText "Written by: "
    , link "https://sonnym.github.io/" (plainText "Sonny Michaud")
    , plainText ". Source is available on "
    , link "https://github.com/sonnym/elm-expressway_doodle" (plainText "github")
    , plainText "."
    ])

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

    baseLineStyle = solid lightCharcoal
    lineStyle = { baseLineStyle | width <- lineWidth }

    filledSquare = filled color (square swatchSize)
    border = outlined lineStyle (square swatchSize)
  in
    collage swatchSize swatchSize [filledSquare, border]

colorSelection : Channel Color
colorSelection = channel lightRed
