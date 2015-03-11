module Doodle.Display where

import Signal
import Window

import Graphics.Element (Element)

import Doodle.Model (colorSelection)
import Doodle.State (state, canvasUpdates)
import Doodle.View (view)
import Doodle.Encoder (color2tuple)

display : Signal Element
display =
  Signal.map3
    view
    Window.dimensions
    (Signal.map color2tuple (Signal.subscribe colorSelection))
    (state canvasUpdates)
