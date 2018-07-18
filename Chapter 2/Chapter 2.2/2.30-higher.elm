module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List as List exposing (..)
import String.Extra exposing (replace)



-- this is defining the square-tree using higher order functions (such as map)


type Tree a
    = Leaf a
    | Branch (List (Tree a))


squareTree : Tree number -> Tree number
squareTree tree =
    let
        scale : Tree number -> Tree number
        scale treeElement =
            case treeElement of
                Leaf num ->
                    Leaf (num * num)

                Branch list ->
                    squareTree treeElement
    in
    case tree of
        Leaf num ->
            Leaf num

        Branch list ->
            Branch
                (map scale list)
                


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
