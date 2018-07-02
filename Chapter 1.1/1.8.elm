module Main exposing (main)

import Html exposing (Html)

--this is the cube root approximation

cube x =
    x * x * x

square x = 
    x * x

average a b c =
    (a + b + c) / 3
    
improve guess x = 
    average guess guess (x / (square guess))
    
cubeRoot guess x = 
    if (goodEnough guess x) then
        guess
    else
        cubeRoot (improve guess x) x

goodEnough guess x = 
    abs (((improve guess x) / guess) - 1) < 0.0001

main : Html msg
main =
    Html.text (toString (cubeRoot 1 512))