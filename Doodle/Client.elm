module Doodle.Client where

import Graphics.Element (Element)

import Doodle.Display (display)

main : Signal Element
main = display

port receiveState : Signal String

port sendInput : Signal Int
port sendInput = Signal.map2 (+) Mouse.x Mouse.y
