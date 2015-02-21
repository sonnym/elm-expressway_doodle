module Doodle.Client where

import Signal

import Color (Color)
import Graphics.Element (Element)

import Doodle.Model (Grid)
import Doodle.State (canvasUpdates)
import Doodle.Display (display)

main : Signal Element
main = display

port receiveState : Signal Grid

port sendInput : Signal ((Int, Int), Color)
port sendInput = canvasUpdates
