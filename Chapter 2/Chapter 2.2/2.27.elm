module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List as List exposing (..)
import String.Extra exposing (replace)



-- Nested lists with reverse and deep reverse


type NestedList a
    = Element a
    | Nested (List (NestedList a))



-- reverse and Deep reverse


reverse : NestedList a -> NestedList a
reverse nested =
    case nested of
        Element a ->
            Element a

        Nested list ->
            Nested
                (List.foldl
                    (::)
                    []
                    list
                )


deepReverse : NestedList a -> NestedList a
deepReverse nested =
    let
        funcAcc : NestedList a -> List (NestedList a) -> List (NestedList a)
        funcAcc node acc =
            deepReverse node :: acc
    in
    case nested of
        Element a ->
            Element a

        Nested list ->
            Nested
                -- if funcAcc is executed like (funcAcc [] list.get(i)) i don't get how it works.
                (List.foldl
                    funcAcc
                    []
                    list
                )



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
        [ li [] [ nestedList |> nestedToString |> text ]
        , li [] [ nestedList |> deepReverse |> nestedToString |> text ]
        ]
