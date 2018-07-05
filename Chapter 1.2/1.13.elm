module Main exposing (main)

import Html exposing (..)
import FoundationMath exposing(fib, exp)

phi = (1 + sqrt(5)) / 2
psi = (1 - sqrt(5)) / 2

phiFunc n =
    (exp phi n) / sqrt(5)

compareFuncs n = 
    abs ((fib n) - (phiFunc n))
    

--second part
secondFunc n =
    ((exp phi n) - (exp psi n)) / sqrt(5)
    
isItTrue n =
    (secondFunc n) == (fib n)
    
main : Html msg
main =
    --lmao as you can see compareFuncs is decreasing
    ul []
    [ li [] [text (toString (compareFuncs 1))]
    , li [] [text (toString (compareFuncs 2))]
    , li [] [text (toString (compareFuncs 3))]
    , li [] [text (toString (compareFuncs 4))]
    , li [] [text (toString (compareFuncs 5))]
    , li [] [text (toString (compareFuncs 6))]
    , li [] [text (toString (compareFuncs 7))]
    , li [] [text (toString (compareFuncs 8))]
    , li [] [text (toString (compareFuncs 9))]
    , li [] [text (toString (compareFuncs 10))]
    , li [] [text (toString (secondFunc 10))]
    ]
    