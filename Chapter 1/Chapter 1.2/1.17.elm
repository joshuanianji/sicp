module Main exposing (main)

import FoundationMath exposing (double, half, isEven)
import Html exposing (..)


-- this was very easy!


fastMult : number -> number -> number
fastMult a b =
    if b == 0 then
        0
    else if isEven b then
        fastMult (double a) (half b)
    else
        a + fastMult a (b - 1)


main : Html msg
main =
    text (toString (fastMult 6 7))
