module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List as List exposing (..)
import String.Extra exposing (replace)



-- Nested lists with fringe


type NestedList a
    = Element a
    | Nested (List (NestedList a))



-- the fringe function


fringe : NestedList a -> List a
fringe nested =
    let
        recur node acc =
            case node of
                Element a ->
                    a :: acc

                Nested list ->
                    List.foldr recur acc list
    in
    recur nested []



-- misc functions to deal with random stuff


nestedToString : NestedList a -> String
nestedToString nestedList =
    let
        stringNested =
            toString nestedList
    in
    stringNested
        |> replace "Nested" ""
        |> replace "Element" ""
        |> replace "(" ""
        |> replace ")" ""
        |> replace " " ""
        |> replace "[" "[ "
        |> replace "]" " ]"
        |> replace "," ", "



-- my nested lists


nestedList : NestedList Int
nestedList =
    Nested
        [ Nested
            [ Element 1
            , Element 2
            , Nested
                [ Element 3
                , Element 5
                ]
            ]
        , Element 4
        ]


nestedListSimple : NestedList Int
nestedListSimple =
    Nested
        [ Nested
            [ Element 1
            , Element 2
            ]
        , Element 3
        ]


singleNestedList : NestedList Int
singleNestedList =
    Element 3


myPairList : NestedList Int
myPairList =
    Nested
        [ Element 3
        , Element 5
        ]


main : Html msg
main =
    ul []
        [ li [] [ nestedList |> fringe |> toString |> text ]
        , li [] [ nestedListSimple |> fringe |> toString |> text ]
        ]
