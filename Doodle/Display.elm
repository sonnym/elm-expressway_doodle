module Doodle.Display where

import Mouse
import Signal
import Window

import Graphics.Element (Element)

import Doodle.Model (state)
import Doodle.View (view, colorSelection)

display : Signal Element
display = Signal.map3 view Window.dimensions (Signal.subscribe colorSelection) state
