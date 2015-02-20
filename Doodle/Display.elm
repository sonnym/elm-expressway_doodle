module Doodle.Display where

import Signal
import Window

import Graphics.Element (Element)

import Doodle.Model (colorSelection)
import Doodle.State (state, canvasUpdates)
import Doodle.View (view)

display : Signal Element
display = Signal.map3 view Window.dimensions (Signal.subscribe colorSelection) (state canvasUpdates)
