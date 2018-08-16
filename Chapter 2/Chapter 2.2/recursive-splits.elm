module Main exposing (..)

import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Figure exposing (figure)
import Html exposing (Html)


-- corner split and right split


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


rightSplit : Collage msg -> Int -> Collage msg
rightSplit painter n =
    if n == 0 then
        painter
    else
        let
            smallerPic =
                rightSplit
                    (painter |> scale 0.5)
                    (n - 1)
        in
        sideBySide painter
            (topAndBottom smallerPic smallerPic)


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


cornerSplit : Collage msg -> Int -> Collage msg
cornerSplit painter n =
    if n == 0 then
        painter
    else
        let
            up =
                upSplit (painter |> scale 0.5) (n - 1)

            right =
                rightSplit (painter |> scale 0.5) (n - 1)

            topLeft =
                sideBySide up up

            bottomRight =
                topAndBottom right right

            corner =
                cornerSplit (painter |> scale 0.5) (n - 1)
        in
        sideBySide
            (topAndBottom topLeft painter)
            (topAndBottom corner bottomRight)


main : Html msg
main =
    rightSplit figure 3
        |> svg
