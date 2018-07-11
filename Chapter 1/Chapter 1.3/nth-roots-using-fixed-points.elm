module Main exposing (main)

import Html exposing (Html)

-- I use fixed points to calculate nth roots of numbers. Whoa this is actually 1.45 lmao
-- 1.45 wants me to do nth roots but with the repeated function for average dampening, because one average dampening doesn't work for fourth roots. I'll make another one on 1.45.elm

square x =
    x * x

exp a b = 
    if b == 0 then
        1
    else 
        a * (exp a (b - 1))

average a b =
    (a + b) / 2

fixedPoint f firstGuess =
    let
        tolerance =
            0.00001

        closeEnough v1 v2 =
            abs (v1 - v2) < tolerance

        try guess =
            let
                next =
                    f guess
            in
                if closeEnough guess next then
                    next
                else
                    try next
    in
        try firstGuess
        
averageDamp f =
    -- if i just return average x (f x) then the compiler would be like where the f come from lmao
    \x -> average x (f x)

sqrtIter x = 
    fixedPoint
        (averageDamp
            -- this is the actual function of the square root we find the fixed point of
            (\y -> x / y))
        1.0

nthRoot x n =
    fixedPoint
        (averageDamp
            (\y -> x / (exp y (n - 1))))
        1.0 


main : Html msg
main =
    nthRoot 27 3
        |> toString
        |> Html.text
