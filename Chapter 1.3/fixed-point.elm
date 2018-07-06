module Main exposing (main)

import Html exposing (Html)

-- finding fixed points of a cubic function

fixedPoint f firstGuess =
    let
        tolerance =
            0.00001

        closeEnough v1 v2 =
            abs (v1 - v2) < tolerance

        try guess =
            let
                next =
                    f guess
            in
                if closeEnough guess next then
                    next
                else
                    try next
    in
        try firstGuess


cubic x =
    (x - 0.5) * (x - 1) * (x + 1)

main : Html msg
main =
    fixedPoint (\y -> sin y + cos y) 1.0
        |> toString
        |> Html.text
