module Doodle.Client where

import Mouse
import Signal

import Graphics.Collage (collage, toForm, scale)
import Graphics.Element (..)

import Window

import Doodle.View (view)

main : Signal Element
main = Signal.map scaledView Window.dimensions

port receiveState : Signal String

port sendInput : Signal Int
port sendInput = Signal.map2 (+) Mouse.x Mouse.y

scaledView : (Int, Int) -> Element
scaledView (width,height) =
  let
    v = view

    viewWidth = toFloat ((widthOf view) + 100)
    viewHeight = toFloat ((heightOf view) + 100)

    scaleFactor = min ((toFloat width) / viewWidth) ((toFloat height) / viewHeight)
  in
    collage width height [v |> toForm |> scale scaleFactor]
