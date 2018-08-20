module Main exposing (main)

import Html exposing (Html)
import List exposing (..)


-- defining sets as lists without duplicates


type alias Set a =
    List a



-- lol i'm not going to use this


elementOfSet : a -> Set a -> Bool
elementOfSet elem set =
    member elem set


ajoinSet : a -> Set a -> Set a
ajoinSet x set =
    if member x set then
        set
    else
        x :: set


intersectionSet : Set a -> Set a -> Set a
intersectionSet set1 set2 =
    case set1 of
        [] ->
            []

        x :: xs ->
            case set2 of
                [] ->
                    []

                _ ->
                    if member x set2 then
                        x :: intersectionSet xs set2
                    else
                        intersectionSet xs set2


unionSet : Set a -> Set a -> Set a
unionSet set1 set2 =
    let
        removeDuplicates set =
            case set of
                [] ->
                    []

                x :: xs ->
                    if member x xs then
                        removeDuplicates xs
                    else
                        x :: removeDuplicates xs
    in
    removeDuplicates (append set1 set2)


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
    ajoinSet e1 s2
        |> toString
        |> Html.text
