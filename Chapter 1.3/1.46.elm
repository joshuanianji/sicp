module Main exposing (main)

import Html exposing (Html)



-- We abstract our iteration functions to make iterativeImprove. It takes in a 2 parameter: goodEnough and improveGuess, and outputs a function that takes in a guess and computes the answer straight away


average a b =
    (a + b) / 2


iterativeImprove goodEnough improveGuess =
    let
        iterativeImproveIter test improve guess =
            if test guess then
                guess
            else
                iterativeImproveIter test improve (improve guess)
    in
    iterativeImproveIter goodEnough improveGuess



--square root thing based on iterativeImprove


sqrtIter guess x =
    let
        improve guess =
            average guess (x / guess)

        goodEnough guess =
            abs (improve guess / guess - 1) < 0.01
    in
    iterativeImprove goodEnough improve guess


sqrt x =
    sqrtIter 1 x



-- fixed point thing based on iterative improve


fixedPoint f guess =
    let
        tolerance =
            0.00001

        closeEnough guess =
            abs (guess - f guess) < tolerance

        improve guess =
            f guess
    in
    iterativeImprove closeEnough improve guess



-- random functions to play around with for the fixed point


inverse x =
    1 / (x - 1)


main : Html msg
main =
    fixedPoint inverse 1
        |> toString
        |> Html.text
