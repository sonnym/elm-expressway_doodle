module Doodle.State where

import Array (Array, repeat)
import Color (Color, lightBlue)
import Signal (Signal, Channel, channel, subscribe, constant, map2, dropRepeats)

import Doodle.Model (..)

state : Signal Grid
state = constant initial

initial : Grid
initial =
  repeat
    (displayWidth // pixelSize)
    (repeat (canvasHeight // pixelSize) lightBlue)

canvasUpdates : Signal ((Int, Int), Color)
canvasUpdates = map2 (,) (subscribe paint) (subscribe colorSelection) |> dropRepeats
