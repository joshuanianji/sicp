module Main exposing (main)

import Html exposing (Html)

square x =
    x * x

average a b =
    (a + b) / 2
    
improve guess x = 
    average guess (x / guess)
    
sqrtifier guess x = 
    if (goodEnough guess x) then
        guess
    else
        sqrtifier (improve guess x) x

goodEnough guess x = 
    abs (((improve guess x) / guess) - 1) < 0.01

main : Html msg
main =
    Html.text (toString (sqrtifier 1 0.0004))