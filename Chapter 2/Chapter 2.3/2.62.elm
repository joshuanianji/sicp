module Main exposing (main)

import Html exposing (Html)
import List exposing (..)


-- defining sets as lists without duplicates and they have to be comparable


type alias Set comparable =
    List comparable



-- sicp wanted me to make elementOfSet faster than before but since I'm using the native code I'm guessing it's about as fast as it could be.


elementOfSet : comparable -> Set comparable -> Bool
elementOfSet elem set =
    member elem set


ajoinSet : comparable -> Set comparable -> Set comparable
ajoinSet x set =
    if member x set then
        set
    else
        x :: set


intersectionSet : Set comparable -> Set comparable -> Set comparable
intersectionSet set1 set2 =
    case set1 of
        [] ->
            []

        x :: xs ->
            case set2 of
                [] ->
                    []

                y :: ys ->
                    if y == x then
                        y :: intersectionSet xs ys
                    else if y < x then
                        intersectionSet xs set2
                    else
                        intersectionSet set1 ys


unionSet : Set comparable -> Set comparable -> Set comparable
unionSet set1 set2 =
    case set1 of
        [] ->
            set2

        x :: xs ->
            case set2 of
                [] ->
                    set1

                y :: ys ->
                    if y == x then
                        y :: unionSet xs ys
                    else if y < x then
                        y :: unionSet set1 ys
                    else
                        x :: unionSet xs set2


s1 : Set Int
s1 =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


s2 : Set Int
s2 =
    [ 2, 4, 6, 8, 10, 12 ]


e1 : Int
e1 =
    4


main : Html msg
main =
    unionSet s1 s2
        |> toString
        |> Html.text
