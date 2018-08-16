module Stickman exposing (stickman)

import Collage exposing (..)
import Collage.Layout exposing (center, horizontal, spacer, vertical)
import Color exposing (..)


-- the stickman module - DOESN'T WORK!! lmao the stickmen are all whack unless you add a debug function after the stickman function.
-- maybe it's because I grouped them so differently - the center is whack and everything's kinda shifted downwards. Idk though.


arms : Collage msg
arms =
    path [ ( -60, 40 ), ( -30, 0 ), ( 30, 0 ), ( 60, -40 ) ]
        |> traced (solid thin (uniform Color.black))


torso : Collage msg
torso =
    line 75
        |> traced defaultLineStyle
        |> rotate (degrees 90)


legs : Collage msg
legs =
    path [ ( -40, 0 ), ( 0, 80 ), ( 40, 0 ) ]
        |> traced (solid thin (uniform Color.black))


head : Collage msg
head =
    circle 25
        |> filled (uniform black)


stickman : Collage msg
stickman =
    group
        [ head
        , torso |> shift ( 0, -50 )
        , arms |> shift ( 0, -50 )
        , legs |> shift ( 0, -165 )
        ]
        |> center
