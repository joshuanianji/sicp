module Main exposing (main)

import Html exposing (Html)
import List exposing (..)


-- Finds all ordered triplets of unique integers less than or equal to a given integer n that sums to a given integer s
-- Helper functions


flatMap : (a -> List b) -> List a -> List b
flatMap proc seq =
    foldr
        append
        []
        (map proc seq)

-- Lmao flatten is basically flatMap except simpler
flatten : List (List a) -> List a
flatten list =
    foldr
        append
        []
        list


filterSum : List (List number) -> number -> List (List number)
filterSum list sum =
    filter
        (\listElem ->
            foldr (+) 0 listElem == sum
        )
        list



-- Big boys


orderedTripletsNested : Int -> List (List (List Int))
orderedTripletsNested n =
    flatMap
        (\i ->
            map
                (\j ->
                    map
                        (\k ->
                            [ i, j, k ]
                        )
                        (range 1 (j - 1))
                )
                (range 2 (i - 1))
        )
        (range 3 n)


orderedTriplets : Int -> List (List Int)
orderedTriplets n =
    flatten (orderedTripletsNested n)


tripletSumInt : Int -> Int -> List (List Int)
tripletSumInt upperBound sum =
    filterSum
        (orderedTriplets upperBound)
        sum


main : Html msg
main =
    tripletSumInt 5 8
        |> toString
        |> Html.text
