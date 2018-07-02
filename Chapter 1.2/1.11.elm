module Main exposing (main)

import Html exposing (..)
    
-- recursive definition

recursiveFunc n = 
    if n < 3 then
        n
    else
        (recursiveFunc (n - 1)) + 
        2 * (recursiveFunc (n - 2)) + 
        3 * (recursiveFunc (n - 3))
        
iterFunc n =
    iterations 2 1 0 n

iterations a b c count = 
    if count == 0 then
        c
    else 
        iterations (a + 2*b + 3*c) a b (count - 1)

main : Html msg
main =
    ul []
    [ li [] [text ((toString (recursiveFunc 20)))]
    , li [] [text (toString (iterFunc 20))]
    ]