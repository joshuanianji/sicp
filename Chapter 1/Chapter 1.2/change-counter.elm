module Main exposing (main)

import Html exposing (Html)


coinChange : Int -> Int
coinChange amount =
    cc amount 5


cc : Int -> Int -> Int
cc amount kindsOfCoins =
    if amount == 0 then
        1
    else if amount < 0 || kindsOfCoins == 0 then
        0
    else
        -- this part kind of confuses me
        cc amount (kindsOfCoins - 1) + cc (amount - coinValue kindsOfCoins) kindsOfCoins


coinValue : Int -> Int
coinValue kindOfCoin =
    case kindOfCoin of
        1 ->
            1

        2 ->
            5

        3 ->
            10

        4 ->
            25

        _ ->
            50


main : Html msg
main =
    Html.text (toString (coinChange 11))
