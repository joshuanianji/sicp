module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Maybe exposing (..)


-- reversing a list


numList =
    range 4 10


reverse : List a -> List a
reverse list =
    if length list == 0 then
        []
    else
        append (reverse (withDefault [] (tail list)))
            (filterMap
                head
                --why do we need to put list in another list???? What???
                [ list ]
            )


main : Html msg
main =
    reverse numList
        |> toString
        |> Html.text
