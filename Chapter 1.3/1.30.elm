module Main exposing (main)

import Html exposing (Html)

isEven : Float -> Bool
isEven x = 
    toFloat( floor (x / 2) * 2 ) == x

cube : Float -> Float
cube x = 
    x * x * x

inc x =
    x + 1

sum : (Float -> Float) -> Float -> (Float -> Float) -> Float -> Float
sum term a next b =
    if a > b then
        0
    else 
        (term a) + (sum term (next a) next b)
        
sumIter term a next b =
    let
        iter a result =
            if a > b then
                result
            else
                iter (next a) (result + term a)
    in
        iter a 0

main : Html msg
main =
    sumIter cube 1 inc 10
        |> toString
        |> Html.text
