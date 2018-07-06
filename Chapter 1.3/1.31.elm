module Main exposing (main)

import Html exposing (Html)


-- i have to change isEven to wok on floats


isEven : Float -> Bool
isEven x =
    toFloat (floor (x / 2) * 2) == x


cube : Float -> Float
cube x =
    x * x * x


inc x =
    x + 1


product term a next b =
    if a > b then
        1
    else
        term a * product term (next a) next b


productIter term a next b =
    let
        iter a result =
            if a > b then
                result
            else
                iter (next a) (result * term a)
    in
    iter a 1


piApprox n =
    let
        term n =
            if isEven n then
                (n + 2) / (n + 1)
            else 
                (n + 1) / (n + 2)
    in
        4 * productIter term 1 inc n


main : Html msg
main =
    piApprox 1000
        |> toString
        |> Html.text
