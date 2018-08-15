module Stickman exposing (stickMan)

import Collage exposing (..)
import Collage.Layout exposing (at, horizontal, topLeft)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html)


arms : Collage msg
arms =
    line 75
        |> traced defaultLineStyle


torso : Collage msg
torso =
    line 75
        |> traced defaultLineStyle
        |> rotate (degrees 90)


legs : Collage msg
legs =
    horizontal
        [ leftLeg
        , rightLeg
        ]
        |> shift ( -12, 0 )


rightLeg : Collage msg
rightLeg =
    line 50
        |> traced defaultLineStyle
        |> rotate (degrees -60)


leftLeg : Collage msg
leftLeg =
    line 50
        |> traced defaultLineStyle
        |> rotate (degrees 60)


head : Collage msg
head =
    circle 25
        |> filled (uniform black)


stickMan : Collage msg
stickMan =
    group
        [ head
        , torso |> shift ( 0, -50 )
        , arms |> shift ( 0, -50 )
        , legs |> shift ( 0, -107 )
        ]
