module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List as List exposing (..)
import String.Extra exposing (replace)


-- an abstract treeMap function


type Tree a
    = Leaf a
    | Branch (List (Tree a))


square : number -> number
square x =
    x * x


treeMap : (a -> b) -> Tree a -> Tree b
treeMap func tree =
    let
        mapper : Tree a -> Tree b
        mapper treeElement =
            case treeElement of
                Leaf a ->
                    Leaf (func a)

                Branch list ->
                    treeMap func treeElement
    in
    case tree of
        Leaf a ->
            Leaf (func a)

        Branch list ->
            Branch
                (map mapper list)


squareTree : Tree number -> Tree number
squareTree tree =
    treeMap square tree


treeToString : Tree a -> String
treeToString nestedList =
    let
        stringNested =
            toString nestedList
    in
    stringNested
        |> replace "Leaf" ""
        |> replace "Branch" ""
        |> replace "(" ""
        |> replace ")" ""
        |> replace "," ", "


myTree : Tree Int
myTree =
    Branch
        [ Leaf 4
        , Branch
            [ Leaf 5
            , Leaf 7
            ]
        , Leaf 5
        , Branch
            [ Leaf 6
            , Leaf 8
            ]
        ]


main : Html msg
main =
    ul []
        [ li []
            [ myTree
                |> treeToString
                |> text
            ]
        , li []
            [ squareTree myTree
                |> treeToString
                |> text
            ]
        ]
