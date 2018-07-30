module Main exposing (main)

import Html exposing (Html)


cuberoot : Float -> Float
cuberoot inputCube =
    let
        cube a =
            a * a * a

        square a =
            a * a

        estimate =
            1.0

        average a b c =
            (a + b + c) / 3

        improve guess x =
            average guess guess (x / square guess)

        goodEnough guess x =
            abs ((improve guess x / guess) - 1) < 0.0001

        cuberootIter : Float -> Float -> Float
        cuberootIter guess x =
            if goodEnough guess x then
                guess
            else
                cuberootIter (improve guess x) x
    in
    cuberootIter estimate inputCube


main : Html msg
main =
    Html.text (toString (cuberoot 1000.0))
