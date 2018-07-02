module Main exposing (main)

import Html exposing (Html)

square x = 
    x * x
    
returnSmaller a b =
    if (a < b) then
        a
    else 
        b

returnSmallerNum a b c =
    --looks at a or b first to determine what is smaller, then looks at c
    returnSmaller c (returnSmaller a b)
    
largerSquares a b c = 
    (square a) + (square b) + (square c) - (square (returnSmallerNum a b c))

main : Html msg
main =
    Html.text (toString (largerSquares 1 2 3))
