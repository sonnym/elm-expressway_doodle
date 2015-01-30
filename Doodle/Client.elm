module Doodle.Client where

import Mouse
import Signal

import Graphics.Collage (collage, toForm, scale)
import Graphics.Element (..)

import Window

import Doodle.View (view)

main : Signal Element
main = Signal.map view Window.dimensions

port receiveState : Signal String

port sendInput : Signal Int
port sendInput = Signal.map2 (+) Mouse.x Mouse.y
