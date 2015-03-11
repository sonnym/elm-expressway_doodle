module Doodle.Server where

import Color (Color)
import Signal

import Doodle.Model (Grid)
import Doodle.State (state)

import Doodle.Decoder (decode)

-- Boilerplate
import Text
main = Text.asText "main"

port receiveInput : Signal ((Int, Int), (Int, Int, Int))

port sendState : Signal Grid
port sendState = state receiveInput
