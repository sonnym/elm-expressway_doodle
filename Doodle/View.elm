module Doodle.View where

import Array
import String (join)
import Text (asText, plainText)

import List ((::), foldr, intersperse, map)
import Signal (Channel, channel, send)

import Color (Color, black, lightCharcoal, lightRed)
import Graphics.Collage (collage, solid, filled, scale, square, outlined, toForm)
import Graphics.Element (..)
import Graphics.Input (customButton)

import Svg (Svg, svg, rect)
import Svg.Lazy (lazy)
import Svg.Attributes as SvgAttr

import Html (Html, toElement)

import Doodle.Model (..)

view : (Int, Int) -> Color -> Grid -> Element
view (width,height) selected grid =
  let
    padding = spacer 0 10
  in
    container
      width height middle
      (flow down [palette selected, padding, canvas grid, padding, footer])

palette : Color -> Element
palette selected =
  flow right
    (intersperse (spacer palettePadding swatchSize)
      (map (swatchButton selected) colors))

canvas : Grid -> Element
canvas grid =
  toElement displayWidth canvasHeight
    ((svg >> lazy)
      [ SvgAttr.version "1.1"
      , SvgAttr.x "0"
      , SvgAttr.y "0"
      , SvgAttr.viewBox (join " " ["0", "0", toString displayWidth, toString canvasHeight])
      ]
      (polygons grid))

polygons : Grid -> List Svg
polygons grid =
  foldr (\(x,column) lst ->
    (foldr (\(y,color) lst ->
      ((rect >> lazy) [ SvgAttr.fill "#000000"
            , SvgAttr.x (toString (x * pixelSize))
            , SvgAttr.y (toString (y * pixelSize))
            , SvgAttr.width (toString pixelSize)
            , SvgAttr.height (toString pixelSize)
            ] []) :: lst)
      lst column))
    [] (Array.toIndexedList (Array.map Array.toIndexedList grid))

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
