module Doodle.Server where

import Color (Color)
import Signal

import Doodle.Model (Grid)
import Doodle.State (state)

-- Boilerplate
import Text
main = Text.asText "main"

port receiveInput : Signal ((Int, Int), Color)

port sendState : Signal Grid
port sendState = state receiveInput
