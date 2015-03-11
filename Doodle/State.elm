module Doodle.State where

import Array (Array, repeat, get, set)
import Color (Color, toRgb, lightBlue)
import Signal (Signal, Channel, channel, subscribe, foldp, map, map2, dropRepeats, keepWhen)

import Doodle.Model (..)
import Doodle.Encoder (encode, color2tuple)

state : Signal Update -> Signal Grid
state source = foldp update initial source

initial : Grid
initial =
  repeat
    (displayWidth // pixelSize)
    (repeat (canvasHeight // pixelSize) (color2tuple lightBlue))

update : ((Int, Int), (Int, Int, Int)) -> Grid -> Grid
update ((x,y), color) grid =
  let
    columnResult = get x grid
  in
    case columnResult of
      Just column -> set x (set y color column) grid
      Nothing -> grid

canvasUpdates : Signal Update
canvasUpdates =
  map2 (,) (subscribe paint) (subscribe colorSelection)
    |> map encode
    |> keepWhen (subscribe mouseDown) ((-1, -1), (color2tuple lightBlue))
    |> dropRepeats
