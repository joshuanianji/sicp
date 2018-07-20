module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List exposing (..)

import NestedMapping exposing (flatMap, makePairSum, isPrimeSum)

-- rewriting the primeSumPairs with uniquePairs to make it neater lol

uniquePairs : Int -> List ( Int, Int )
uniquePairs n =
    flatMap
        (\i ->
            map
                (\j ->
                    ( i, j )
                )
                (range 1 (i - 1))
        )
        (range 1 n)

primeSumPairs : Int -> List (List Int)
primeSumPairs n =
    map makePairSum
        (filter
            isPrimeSum
            (uniquePairs n)
        )



toHtml : a -> Html msg
toHtml a =
    a
        |> toString
        |> Html.text


main : Html msg
main =
    ul []
        [ li [] [ toHtml (primeSumPairs 5) ]
        , li [] [ toHtml (primeSumPairs 6) ]
        ]