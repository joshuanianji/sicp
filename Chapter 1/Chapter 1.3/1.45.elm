module Main exposing (main)

import Html exposing (Html)


-- I use fixed points and average dampening to calculate nth roots of numbers. hte evolved version of n-th roots


exp a b =
    if b == 0 then
        1
    else
        a * exp a (b - 1)


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


repeated : (a -> a) -> Int -> (a -> a)
repeated f n =
    let
        identity x =
            x
    in
    if n == 0 then
        -- repeats 0 times
        identity
    else if n == 1 then
        f
    else
        \x -> f (repeated f (n - 1) x)


recursiveAvgDamp n =
    repeated averageDamp n


nthRoot x n =
    fixedPoint
        (recursiveAvgDamp (floor (logBase 2 n))
            (\y -> x / exp y (n - 1))
        )
        1.0


main : Html msg
main =
    nthRoot 17 1
        |> toString
        |> Html.text
