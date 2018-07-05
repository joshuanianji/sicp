module Main exposing (main)

import Html exposing (..)

import FoundationMath exposing (isEven, double, half)
-- this was very easy!

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
