module Main exposing (main)

import Html exposing (..)
import FoundationMath exposing (square, isEven)
    
-- i kinda het this, because the value of ab^n remains unchanged form state to state 
fastExponentIter b n a =
    if n == 0 then
        a
    else if isEven n then
        fastExponentIter (square b) (n / 2) a
    else 
        fastExponentIter b (n - 1) (a * b)

main : Html msg
main =
    text (toString (fastExponentIter 3 3 1))
