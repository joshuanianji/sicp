module Main exposing (main)

import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Figure exposing (figure)
import Html exposing (Html)


-- defines a function called upSplit


sideBySide : Collage msg -> Collage msg -> Collage msg
sideBySide painter1 painter2 =
    horizontal
        [ painter1
        , painter2
        ]
        |> center


topAndBottom : Collage msg -> Collage msg -> Collage msg
topAndBottom painter1 painter2 =
    vertical
        [ painter1
        , painter2
        ]
        |> center


upSplit : Collage msg -> Int -> Collage msg
upSplit painter n =
    if n == 0 then
        painter
    else
        let
            smallerPic =
                upSplit
                    (painter |> scale 0.5)
                    (n - 1)
        in
        topAndBottom
            (sideBySide smallerPic smallerPic)
            painter


main : Html msg
main =
    upSplit figure 3
        |> svg
