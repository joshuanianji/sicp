module Main exposing (main)

import FoundationMath as Math exposing (double, half, isEven)
import Html exposing (..)


fastMult : number -> number -> number
fastMult a b =
    fastMultIter a b 0


fastMultIter : number -> number -> number -> number
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
