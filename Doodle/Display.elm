module Doodle.Display where

import Mouse
import Signal
import Window

import Graphics.Element (Element)

import Doodle.Model (state, colorSelection)
import Doodle.View (view)

display : Signal Element
display = Signal.map3 view Window.dimensions (Signal.subscribe colorSelection) state
