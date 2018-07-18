module Main exposing (main)

import Debug exposing (..)
import Html exposing (Html)
import List exposing (..)



-- Mapping and square list stuff


prune : Maybe a -> a
prune x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.crash "error: fromJust Nothing"


square : Float -> Float
square x =
    x * x


toList : a -> List a
toList a =
    [ a ]


squareListMap : List Float -> List Float
squareListMap items =
    map square items


squareList : List Float -> List Float
squareList items =
    if length items == 0 then
        []
    else
        append
            (items
                |> head
                |> prune
                |> square
                |> toList
            )
            (squareList
                (items
                    |> tail
                    |> prune
                )
            )


main : Html msg
main =
    [ 1, 2, 3, 4 ]
        |> squareListMap
        |> toString
        |> Html.text
