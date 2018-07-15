module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Maybe exposing (..)


-- reversing a list


prune : Maybe a -> a
prune x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.crash "error: fromJust Nothing"


numList =
    range 4 10


reverse : List a -> List a
reverse list =
    if length list == 0 then
        []
    else
        append (reverse (prune (tail list)))
            -- i had to put it in square brackets because append needs both parameters to be a list
            [ prune (head list) ]


main : Html msg
main =
    reverse numList
        |> toString
        |> Html.text
