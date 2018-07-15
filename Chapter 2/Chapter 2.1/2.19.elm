module Main exposing (main)

import Debug exposing (..)
import Html exposing (Html)
import List exposing (..)


prune : Maybe a -> a
prune x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.crash "error: fromJust Nothing"


reverse : List a -> List a
reverse list =
    if length list == 0 then
        []
    else
        append (reverse (prune (tail list)))
            -- i had to put it in square brackets because append needs both parameters to be a list
            [ prune (head list) ]


coinChange : Float -> Int
coinChange amount =
    cc amount (reverse usCoins)


cc : Float -> List Float -> Int
cc amount coinValues =
    if amount == 0 then
        1
    else if amount < 0 || noMore coinValues then
        0
    else
        -- this part kind of confuses me
        cc amount (exceptFirstDenomination coinValues)
            + cc (amount - firstDenomination coinValues) coinValues


exceptFirstDenomination : List Float -> List Float
exceptFirstDenomination list =
    prune (tail list)


firstDenomination : List Float -> Float
firstDenomination list =
    prune (head list)


noMore : List a -> Bool
noMore list =
    length list == 0


usCoins =
    [ 1, 5, 10, 25, 50 ]


ukCoins =
    [ 0.5, 1, 2, 5, 10, 20, 50, 100 ]


main : Html msg
main =
    coinChange 100
        |> toString
        |> Html.text
