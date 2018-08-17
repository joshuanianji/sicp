module Figure exposing (figure)

import Collage exposing (..)
import Color exposing (..)


-- Dad's figure model that works lmao


figure : Collage msg
figure =
    let
        head =
            circle 20 |> filled (uniform Color.black)

        body =
            segment ( 0, -40 ) ( 0, 40 )
                |> traced (solid thin (uniform Color.black))

        hands =
            path [ ( -50, 40 ), ( -30, 0 ), ( 30, 0 ), ( 50, -40 ) ]
                |> traced (solid thin (uniform Color.black))

        legs =
            path [ ( -30, 0 ), ( 0, 80 ), ( 30, 0 ) ]
                |> traced (solid thin (uniform Color.black))
    in
    group
        [ head |> shift ( 0, 80 )
        , body |> shift ( 0, 20 )
        , hands
        , legs |> shift ( 0, -100 )
        ]
