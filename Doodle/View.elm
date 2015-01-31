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
  let
    width = displayWidth
    height = canvasHeight

    floatWidth = toFloat width
    floatHeight = toFloat height

    border = outlined (solid black) (rect (toFloat width) (toFloat height))
    pixels = gridToForm grid
  in
    collage width height (border :: pixels)

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

gridToForm : Grid -> List Form
gridToForm grid =
  let
    lst = []
    _ = Array.indexedMap (\x col ->
          Array.indexedMap (\y color ->
            (square 1
              |> filled lightRed
              |> move (-(toFloat displayWidth / 2) + toFloat x, (toFloat canvasHeight / 2) - toFloat y))
            :: lst)
          col)
        grid
  in lst
  {--
  let
    indexed = Array.toIndexedList (Array.map Array.toIndexedList grid)
  in
    foldl (\indexedCol lst ->
      let
        x = fst indexedCol
        col = snd indexedCol
      in
        foldl (\indexedCell lst ->
          let
            y = fst indexedCell
            color = snd indexedCell

            pixel = square 1
              |> filled lightRed
              |> move (-(toFloat displayWidth / 2) + toFloat x, (toFloat canvasHeight / 2) - toFloat y)
        in
          pixel :: lst)
      lst col)
    [] indexed
  --}

colorSelection : Channel Color
colorSelection = channel lightRed
