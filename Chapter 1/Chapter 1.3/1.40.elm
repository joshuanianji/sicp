module Main exposing (main)

import Html exposing (Html)


-- approximating zeroes of a cubic function


square x =
    x * x


cube x =
    x * x * x


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


derivative f =
    let
        dx =
            0.000001
    in
    \x -> (f (x + dx) - f x) / dx


newtonTransform g =
    \x ->
        x - (g x / derivative g x)


newtonsMethod g guess =
    fixedPoint (newtonTransform g) guess


cubic a b c =
    \x -> cube x + a * square x + b * x + c


main : Html msg
main =
    newtonsMethod (cubic 3 1 1) 1
        |> toString
        |> Html.text
