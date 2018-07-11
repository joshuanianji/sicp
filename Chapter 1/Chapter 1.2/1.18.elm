module Main exposing (main)

import Html exposing (..)

import FoundationMath  as Math exposing (isEven, double, half)

fastMult a b =
    fastMultIter a b 0
    
fastMultIter a b n = 
    if b == 0 then
        n
    else if isEven b then
        fastMultIter (double a) (half b) n
    else
        fastMultIter a (b - 1) (n + a)

main : Html msg
main =
    text (toString (fastMult 2 7))