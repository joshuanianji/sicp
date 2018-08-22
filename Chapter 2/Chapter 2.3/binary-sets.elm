module Main exposing (main)

import Html exposing (Html)


-- LMAO this tree IS better
-- this should be part of 2.65 bt I can't do it irght now rip


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


member : comparable -> Tree comparable -> Bool
member elem tree =
    case tree of
        Empty ->
            False

        Node a left right ->
            if elem == a then
                True
            else if elem < a then
                member elem left
            else
                member elem right


adjoinSet : comparable -> Tree comparable -> Tree comparable
adjoinSet elem tree =
    case tree of
        Empty ->
            Node elem Empty Empty

        Node a left right ->
            if elem == a then
                tree
            else if elem < a then
                Node a (adjoinSet elem left) right
            else
                Node a left (adjoinSet elem right)



-- I cannot do the union and intersection rip


mySet : Tree Int
mySet =
    Node 7
        (Node 3
            (Node 1 Empty Empty)
            (Node 5 Empty Empty)
        )
        (Node 9
            Empty
            (Node 11 Empty Empty)
        )


myOtherSet : Tree Int
myOtherSet =
    Node 2
        (Node 1 Empty (Node 4 Empty Empty))
        (Node 7 Empty Empty)


main : Html msg
main =
    adjoinSet 3 myOtherSet
        |> toString
        |> Html.text
