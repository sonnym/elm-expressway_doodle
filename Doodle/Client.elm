module Doodle.Client where

import Signal

import Color (Color)
import Graphics.Element (Element)

import Doodle.Model (Grid)
import Doodle.State (canvasUpdates)
import Doodle.Display (display)

import Doodle.Encoder (encode)

main : Signal Element
main = display

port receiveState : Signal Grid

port sendInput : Signal ((Int, Int), (Int, Int, Int))
port sendInput = canvasUpdates
