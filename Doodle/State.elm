module Doodle.State where

import Array (Array, repeat, get, set)
import Color (Color, lightBlue)
import Signal (Signal, Channel, channel, subscribe, foldp, map2, dropRepeats)

import Doodle.Model (..)

state : Signal Grid
state = foldp update initial canvasUpdates

initial : Grid
initial =
  repeat
    (displayWidth // pixelSize)
    (repeat (canvasHeight // pixelSize) lightBlue)

update : ((Int, Int), Color) -> Grid -> Grid
update ((x,y), color) grid =
  let
    columnResult = get x grid
  in
    case columnResult of
      Just column -> set x (set y color column) grid
      Nothing -> grid

canvasUpdates : Signal ((Int, Int), Color)
canvasUpdates =
  map2 (,) (subscribe paint) (subscribe colorSelection)
    |> dropRepeats
