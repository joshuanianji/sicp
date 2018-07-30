module Main exposing (main)

import FoundationMath exposing (exp, fib)
import Html exposing (..)


phi =
    (1 + sqrt 5) / 2


psi =
    (1 - sqrt 5) / 2


phiFunc : Float -> Float
phiFunc n =
    exp phi n / sqrt 5


compareFuncs : Int -> Float
compareFuncs n =
    abs (toFloat (fib n) - phiFunc (toFloat n))



--second part


secondFunc : Int -> Float
secondFunc n =
    (exp phi n - exp psi n) / sqrt 5


isItTrue : Float -> Float
isItTrue n =
    secondFunc n == fib n


main : Html msg
main =
    --lmao as you can see compareFuncs is decreasing
    ul []
        [ li [] [ text (toString (compareFuncs 1)) ]
        , li [] [ text (toString (compareFuncs 2)) ]
        , li [] [ text (toString (compareFuncs 3)) ]
        , li [] [ text (toString (compareFuncs 4)) ]
        , li [] [ text (toString (compareFuncs 5)) ]
        , li [] [ text (toString (compareFuncs 6)) ]
        , li [] [ text (toString (compareFuncs 7)) ]
        , li [] [ text (toString (compareFuncs 8)) ]
        , li [] [ text (toString (compareFuncs 9)) ]
        , li [] [ text (toString (compareFuncs 10)) ]
        , li [] [ text (toString (secondFunc 10)) ]
        ]
