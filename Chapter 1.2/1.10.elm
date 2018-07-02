module Main exposing (main)

import Html exposing (Html)

-- the Ackermann function (very cool stuff invlving hyperoperations)

ackermann x y = 
    if y == 0 then
        0
    else if x == 0 then
        2 * y
    else if y == 1 then
        2
    else
        ackermann (x - 1) (ackermann x (y - 1)) 
   
main : Html msg
main =
    Html.text (toString (ackermann 2 4))